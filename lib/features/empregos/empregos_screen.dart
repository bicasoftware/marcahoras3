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
import 'porcentagens/porcentagens/porcentagens_tile.dart';
import 'salarios/salarios_tile.dart';

class EmpregosScreen extends StatefulWidget {
  const EmpregosScreen();

  @override
  State<EmpregosScreen> createState() => _EmpregosScreenState();
}

class _EmpregosScreenState extends State<EmpregosScreen>
    with EmpregosScreenPresenterMixin, DiferenciaisPresenterMixin {
  final _formKey = GlobalKey<FormState>();
  final ctrDescricao = TextEditingController();

  late final MoneyMaskedTextController ctrSalarioMasked;
  late final Empregos editableEmprego;

  final List<String> weekDays = DateFormat.EEEE(Platform.localeName)
      .dateSymbols
      .STANDALONEWEEKDAYS
      .map((e) => "${e[0].toUpperCase()}${e.substring(1, e.length)}")
      .toList();

  @override
  void dispose() {
    ctrDescricao.dispose();
    ctrSalarioMasked.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final bloc = context.read<EmpregosBloc>();
    ctrDescricao.text = bloc.state.descricao ?? '';

    if (!mounted) return;
    final format = NumberFormat.simpleCurrency(locale: Platform.localeName);
    ctrSalarioMasked = MoneyMaskedTextController(
      leftSymbol: format.currencySymbol,
      initialValue: bloc.state.salario,
    );

    super.initState();
  }

  Future<void> _validate(EmpregosBloc bloc) async {
    final valid = _formKey.currentState?.validate() ?? false;
    if (valid) {
      if (bloc.validate()) {
        await awaitableTask(
          context: context,
          actualTask: () async {
            await bloc.save();
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
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final state = bloc.state;
    final locale = Localizations.localeOf(context);

    return Scaffold(
      appBar: ShAppBar(
        label: !bloc.state.isEditing
            ? Localiza.find("adicionar")
            : Localiza.find("editarEmprego"),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.save_outlined, color: AppColors.onSecondary),
        //     onPressed: () => _validate(bloc),
        //   ),
        // ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16,
          bottom: 16,
          top: 8,
        ),
        color: colors.surface,
        child: ShWideButton(
          labelId: 'salvar',
          onTap: () => _validate(bloc),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                  ShLabeledListSection(label: Localiza.find('salarios')),
                  SalariosTile(
                    salarios: state.emprego.salarios,
                    horaFixoList: state.emprego.horaFixoList,
                    controller: ctrSalarioMasked,
                    isEditing: bloc.state.isEditing,
                    onAdd: () => handleAumento(bloc),
                    onEdit: (s) => updateSalario(s, bloc),
                    onDelete: (s) => deleteSalario(s, bloc),
                    onSalarioValueChanged: (_) {
                      bloc.setSalario(ctrSalarioMasked.numberValue);
                    },
                  ),
                  LabelFormField<TimeOfDay>(
                    label: Localiza.find("entradaHora"),
                    initialValue:
                        state.entrada ?? TimeOfDay(hour: 8, minute: 00),
                    valueFormatter: (t) => TimeOfDayHelper.formatTime(t),
                    icon: Icons.timelapse_outlined,
                    onTap: () async {
                      showHorasBts(
                        context: context,
                        bloc: bloc,
                        isEntrada: true,
                        time: bloc.state.entrada!,
                      );
                    },
                    validator: (t) {
                      return TimeRangeValidator.validate(
                        initTime: bloc.state.entrada!,
                        endTime: bloc.state.saida!,
                      );
                    },
                  ),
                  LabelFormField<TimeOfDay>(
                    label: Localiza.find("saidaHora"),
                    initialValue:
                        bloc.state.saida ?? TimeOfDay(hour: 18, minute: 00),
                    valueFormatter: (t) {
                      return TimeOfDayHelper.formatTime(t);
                    },
                    icon: Icons.timelapse_outlined,
                    onTap: () {
                      showHorasBts(
                        context: context,
                        bloc: bloc,
                        isEntrada: false,
                        time: bloc.state.saida!,
                      );
                    },
                    validator: (t) {
                      return TimeRangeValidator.validate(
                        initTime: bloc.state.entrada!,
                        endTime: bloc.state.saida!,
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
                  if (!bloc.state.isEditing) ...[
                    ShLabeledListSection(
                      label: Localiza.find("porcentagensExtras"),
                    ),
                    ShSwitchTile(
                      value: state.bancoHoras,
                      label: Localiza.find("bancoHoras"),
                      onTap: (_) => bloc.toggleBancoHoras(),
                    ),
                  ],
                  PorcentagensTile(
                    isInsert: !bloc.state.isEditing,
                    toggleType: bloc.toggleValorFixo,
                    useValorFixo: state.useValorFixo,
                    fixedValues: bloc.state.valorFixo,
                    horaFixoList: bloc.state.getHoraFixoList(),
                    porcNormal: bloc.state.porcNormal ?? 50,
                    porcFeriado: bloc.state.porcFeriado ?? 100,
                    onHoraFixoChanged: (it) {
                      bloc.setValorFixo(it.$1, it.$2);
                    },
                    onNormalPorcChanged: bloc.setPorcNormal,
                    onFeriadoPorcChanged: bloc.setPorcFeriados,
                    onAdd: () => insertHoraFixo(bloc),
                    onEdit: (HoraFixo h) => updateHoraFixo(bloc, h),
                    onDelete: (h) => deleteHoraFixo(bloc, h),
                  ),
                  ShLabeledListSection(
                    label: Localiza.find('horasDiferenciais'),
                  ),
                  ShListViewTile<Diferenciais>(
                    dataList: bloc.state.emprego.diferenciaisList,
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
                          value: CurrencyHelper.formatAmount(
                            CalcHelper.calcPorcentagemHora(
                              salario:
                                  state.emprego.getCurrentSalarioAlt()?.valor ??
                                  0,
                              cargaHoraria: state.emprego.cargaHoraria,
                              porcentagem: d.percentage,
                            ),
                          ),
                          icon: Icons.monetization_on,
                          labelColor: colors.onSurface,
                          iconColor: colors.onSurface,
                        ),
                      ];
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
