import 'dart:io';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain_layer/models.dart';
import '../../presentation_layer/blocs.dart';
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

  Future<void> _validate(EmpregosBloc bloc) async {
    final valid = _formKey.currentState?.validate() ?? false;
    if (valid) {
      if (bloc.validate()) {
        await awaitableTask(
          context: context,
          actualTask: () async {
            await bloc.persist();
            await context.read<HomeBloc>().load();
            Navigator.of(context).pop();
          },
          popWhenDone: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<EmpregosBloc>();
    final state = bloc.state;
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context);

    return Scaffold(
      appBar: ShAppBar(
        label: bloc.state.isInsert
            ? Localiza.find("adicionar")
            : Localiza.find("editarEmprego"),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16,
          bottom: 32,
          top: 8,
        ),
        color: colors.surface,
        child: ShFormButton.save(() => _validate(bloc)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Form(
              key: _formKey,
              child: BlocHelper<EmpregosBloc, EmpregosState>(
                bloc: bloc,
                onError: (err) async {
                  showErrorDialog(context: context, errorMsg: err);
                  Navigator.of(context).pop();
                },
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 4),
                    ShTextTile(
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
                    ShLabeledListSection('horarios'),
                    LabelFormField<TimeOfDay>(
                      label: Localiza.find("entradaHora"),
                      initialValue: state.entrada,
                      valueFormatter: (t) => TimeOfDayHelper.formatTime(t),
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
                    LabelFormField<TimeOfDay>(
                      label: Localiza.find("saidaHora"),
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
                    LabelFormField<int>(
                      label: Localiza.find("diaFechamento"),
                      initialValue: state.diaFechamento,
                      valueFormatter: (t) {
                        return "${Localiza.find('dia')} $t";
                      },
                      icon: Icons.calendar_today_outlined,
                      onTap: () {
                        showDiaFechamentoPicker(
                          context: context,
                          day: state.diaFechamento,
                          bloc: bloc,
                        );
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
                        onAdd: () => onAddDiferencial(bloc),
                        onEdit: (d) => onUpdateDiferencial(d, bloc),
                        onDelete: (d) => onDeleteDiferencial(d, bloc),
                        buildTitle: (d) => weekDays[d.weekday],
                        buildBadgeLabel: (d) => Localiza.find('diferencial'),
                        buildBadgeColor: (d) => d.color,
                        buildInfoList: (d) {
                          return [
                            IconLabelValue(
                              label: "${d.percentage}%",
                              labelColor: colors.onSurface,
                              icon: Icons.list,
                              iconColor: colors.secondary,
                              value: CurrencyHelper.formatAmount(
                                CalcHelper.calcPorcentagemHora(
                                  salario: state.getCurrentSalario().valor,
                                  cargaHoraria: state.cargaHoraria,
                                  porcentagem: d.percentage,
                                ),
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
