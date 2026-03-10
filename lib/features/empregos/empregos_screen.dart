import 'dart:io';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain_layer/models.dart';
import '../../presentation_layer/blocs.dart';
import '../../presentation_layer/route_args.dart';
import '../../presentation_layer/validators/validators.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'diferenciais_presenter.dart';
import 'empregos_screen_presenter.dart';
import 'porcentagens/porcentagens/porcentagens_sliders.dart';
import 'salarios/salarios_input_tile.dart';
import 'salarios/salarios_tile.dart';

class EmpregosScreen extends StatefulWidget {
  const EmpregosScreen();

  @override
  State<EmpregosScreen> createState() => _EmpregosScreenState();
}

class _EmpregosScreenState extends State<EmpregosScreen>
    with
        EmpregosScreenPresenterMixin,
        DiferenciaisPresenterMixin,
        SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final ctrDescricao = TextEditingController();

  late final MoneyMaskedTextController ctrSalarioMasked;
  late final AnimationController _animateController;
  late final Animation<double> _animation;

  final List<String> weekDays = DateFormat.EEEE(Platform.localeName)
      .dateSymbols
      .STANDALONEWEEKDAYS
      .map((e) => "${e[0].toUpperCase()}${e.substring(1, e.length)}")
      .toList();

  @override
  void dispose() {
    ctrDescricao.dispose();
    ctrSalarioMasked.dispose();
    _animateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    final bloc = context.read<EmpregosBloc>();
    ctrDescricao.text = bloc.state.descricao;

    final format = NumberFormat.simpleCurrency(locale: Platform.localeName);
    ctrSalarioMasked = MoneyMaskedTextController(
      leftSymbol: format.currencySymbol,
      initialValue: bloc.state.getCurrentSalario().valor,
    );

    _animateController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
      value: 1,
    );

    _animation = CurvedAnimation(
      parent: _animateController,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<EmpregosBloc>();
    final state = bloc.state;
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context);
    final empregoArgs =
        ModalRoute.of(context)?.settings.arguments as EmpregosArguments;

    return PopScope(
      canPop: canPop(
        formKey: _formKey,
        bloc: bloc,
        ogEmprego: empregoArgs.emprego,
      ),
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final canPopAnyway = await showConfirmationDialog(
          context: context,
          titleMsg: findText('cancelar'),
          descriptionText: findText('Deseja descartar as alterações?'),
          okLabel: findText('descartar'),
          cancelLabel: findText('voltar'),
        );

        if (canPopAnyway) Navigator.of(context).pop();
      },
      child: ShScaffold(
        appBar: ShAppBar(
          label: bloc.state.isInsert
              ? Localiza.find("adicionar")
              : Localiza.find("editarEmprego"),
        ),

        floatingActionButton: state.didChangeData(empregoArgs.emprego)
            ? FloatingActionButton(
                child: Icon(Icons.save),
                onPressed: () {
                  validate(_formKey, bloc, context.read<HomeBloc>(), true);
                },
                heroTag: "FAB",
              )
            : null,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: .all(8),
            child: Form(
              key: _formKey,
              child: BlocHelper<EmpregosBloc, EmpregosState>(
                bloc: bloc,
                onError: (err) async {
                  showErrorDialog(context: context, errorMsg: err);
                  Navigator.of(context).pop();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ShTextTile(
                      themeColor: colors.primary,
                      controller: ctrDescricao,
                      label: Localiza.find("descricaoEmprego"),
                      hint: Localiza.find("descricaoEmprego"),
                      labelStyle: textTheme.labelLarge,
                      icon: Icons.text_fields,
                      onValueChanged: bloc.setDescricao,
                      validator: (s) {
                        return MinCharactersValidator.validate(
                          ctrDescricao.text,
                          6,
                        );
                      },
                    ),
                    LabelFormField<String>(
                      label: Localiza.find("admissao"),
                      themeColor: colors.primary,
                      initialValue: state.admissao != null
                          ? formatDateByLocale(state.admissao, locale)
                          : Localiza.find('preencherAdmissao'),
                      valueFormatter: (s) => s,
                      icon: Icons.calendar_month,
                      onTap: () => selectDate(context, bloc),
                      validator: (s) {
                        return DateValidator.validate(
                          state.admissao,
                          "admissaoVazia",
                          "dataInvalida",
                        );
                      },
                    ),
                    state.isInsert
                        ? SalariosInputTile(
                            controller: ctrSalarioMasked,
                            onSalarioValueChanged: (s) => bloc.setSalario(s),
                          )
                        : SalariosTile(
                            salarios: state.salariosList,
                            diaFechamento: state.diaFechamento,
                            onAdd: () => handleAumento(bloc),
                            onEdit: (s) => updateSalario(s, bloc),
                            onDelete: (s) => deleteSalario(s, bloc),
                          ),

                    Row(
                      spacing: 4,
                      children: [
                        Expanded(
                          child: LabelFormField<TimeOfDay>(
                            label: Localiza.find("entradaHora"),
                            themeColor: colors.primary,
                            initialValue: state.entrada,
                            valueFormatter: (t) =>
                                TimeOfDayHelper.formatTime(t),
                            icon: Icons.timelapse_outlined,
                            onTap: () async {
                              showHorasBts(
                                context: context,
                                bloc: bloc,
                                isEntrada: true,
                                time: bloc.state.entrada,
                              );
                            },
                            validator: (t) {
                              return TimeRangeValidator.validate(
                                initTime: bloc.state.entrada,
                                endTime: bloc.state.saida,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: LabelFormField<TimeOfDay>(
                            label: Localiza.find("saidaHora"),
                            themeColor: Colors.red,
                            initialValue: bloc.state.saida,
                            valueFormatter: (t) {
                              return TimeOfDayHelper.formatTime(t);
                            },
                            icon: Icons.timelapse_outlined,
                            onTap: () {
                              showHorasBts(
                                context: context,
                                bloc: bloc,
                                isEntrada: false,
                                time: state.saida,
                              );
                            },
                            validator: (t) {
                              return TimeRangeValidator.validate(
                                initTime: state.entrada,
                                endTime: state.saida,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    ShDropdownTile<int>(
                      labelId: 'diaFechamento',
                      selectedItem: state.diaFechamento,
                      items: List.generate(29, (i) => i + 1),
                      icon: Icons.calendar_today_outlined,
                      themeColor: colors.secondary,
                      onItemChanged: (value) {
                        if (value != null) {
                          bloc.setDiaFechamento(value);
                        }
                      },
                      formatItem: (int item) {
                        return "$item".padLeft(2, '0');
                      },
                    ),

                    ShRadioListTile(
                      label: Localiza.find("cargaHorariaSemanal"),
                      icon: Icon(Icons.list),
                      initValue: CargaHoraria.getByMensal(
                        state.cargaHoraria,
                      ),
                      cargaHorarias: CargaHoraria.values,
                      mapValue: (CargaHoraria c) {
                        return Localiza.findAndReplaceByMap(
                          stringKey: 'cargaHorariaRadio',
                          map: {
                            "{SEMANAIS}": "${c.semanal}",
                            "{MENSAIS}": "${c.mensal}",
                          },
                        );
                      },
                      onChanged: (CargaHoraria c) {
                        bloc.setCargaHoraria(c.mensal);
                      },
                    ),
                    ShSwitchTile(
                      value: state.bancoHoras,
                      label: Localiza.find("bancoHoras"),
                      onTap: (s) {
                        bloc.setBancoHoras(s);
                        s
                            ? _animateController.reverse()
                            : _animateController.forward();
                      },
                    ),
                    const SizedBox(height: 4),
                    SizeTransition(
                      sizeFactor: _animation,
                      axis: Axis.vertical,
                      child: PorcentagemSlider(
                        key: ValueKey<bool>(state.bancoHoras),
                        porcNormal: state.porcNormal,
                        porcFeriado: state.porcFeriado,
                        onNormalChanged: bloc.setPorcNormal,
                        onFeriadoChanged: bloc.setPorcFeriados,
                      ),
                    ),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 400),
                      crossFadeState: state.difList.isEmpty
                          ? .showFirst
                          : .showSecond,
                      firstChild: ShEmptyListViewTile(
                        upperLabelId: 'horasDiferenciais',
                        descriptionId: 'horasDiferenciaisVazia',
                        buttonTextId: 'adicionar',
                        icon: Icons.add_chart,
                        onTap: () => onAddDiferencial(bloc),
                      ),
                      secondChild: ShListViewTile<Diferenciais>(
                        dataList: state.difList,
                        outerLabelId: 'diferenciais',
                        onAdd: () => onAddDiferencial(bloc),
                        onEdit: (d) => onUpdateDiferencial(d, bloc),
                        onDelete: (d) => onDeleteDiferencial(d, bloc),
                        buildTitle: (d) => weekDays[d.weekday],
                        buildBadgeLabel: (d) => Localiza.find('diferencial'),
                        buildBadgeColor: (d) => d.color,
                        buildInfoList: (d) {
                          return [
                            Container(
                              padding: .all(4),
                              child: Row(
                                children: [
                                  ShFormLabel.subtitle("${d.percentage}%"),
                                  const Spacer(),
                                  ShFormLabel.title(
                                    CurrencyHelper.formatAmount(
                                      CalcHelper.calcPorcentagemHora(
                                        salario: state
                                            .getCurrentSalario()
                                            .valor,
                                        cargaHoraria: state.cargaHoraria,
                                        porcentagem: d.percentage,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ];
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
