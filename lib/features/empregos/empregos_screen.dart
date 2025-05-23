import 'dart:io';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain_layer/models.dart';
import '../../presentation_layer/blocs.dart';
import '../../presentation_layer/validators/validators.dart';
import '../../resources/colors.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'empregos_screen_presenter.dart';
import 'porcentagens/porcentagens_tile.dart';
import 'salarios/salarios_tile.dart';

class EmpregosScreen extends StatefulWidget {
  const EmpregosScreen();

  @override
  State<EmpregosScreen> createState() => _EmpregosScreenState();
}

class _EmpregosScreenState extends State<EmpregosScreen>
    with EmpregosScreenPresenterMixin {
  // late final bool isInsert;
  final _formKey = GlobalKey<FormState>();
  final ctrDescricao = TextEditingController();

  late final MoneyMaskedTextController ctrSalarioMasked;
  late final Empregos editableEmprego;

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
    final state = bloc.state;
    final locale = Localizations.localeOf(context);
    final theme = Theme.of(context).textTheme;

    /// TODO
    /// Aplicar confirm Dialog ao apagar um valor fixo
    /// Mostrar Bts para editar o valor fixo
    /// Atualizar a tela ao alterar o valor fixo
    /// Aplicar menu popup nas tiles de salário e remover package de Swipe

    return Scaffold(
      appBar: ShAppBar(
        label: !bloc.state.isEditing
            ? Localiza.find("adicionarEmprego")
            : Localiza.find("editarEmprego"),
        actions: [
          IconButton(
            icon: Icon(Icons.save_outlined, color: AppColors.onSecondary),
            onPressed: () => _validate(bloc),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: SingleChildScrollView(
          child: BlocHelper<EmpregosBloc, EmpregosState>(
            bloc: bloc,
            onError: (error) {
              context.showSnackBar(error);
            },
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
                    ShTextTile(
                      controller: ctrDescricao,
                      label: Localiza.find("descricaoEmprego"),
                      hint: Localiza.find("descricaoEmprego"),
                      labelStyle: textTheme.labelLarge,
                      icon: Icon(Icons.text_fields),
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
                    SalariosTile(
                      salarios: state.emprego.salarios,
                      horaFixoList: state.emprego.horaFixoList,
                      controller: ctrSalarioMasked,
                      isEditing: bloc.state.isEditing,
                      onOptionSelected: (action) {
                        handleAumento(action, bloc);
                      },
                      onSalarioValueChanged: (_) {
                        bloc.setSalario(ctrSalarioMasked.numberValue);
                      },
                      onEdit: (s) => updateSalario(s, bloc),
                      onDelete: (s) => deleteSalario(s, bloc),
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
                    ShTogglableTile(
                      label: Localiza.find("cargaHoraria"),
                      value: state.cargaHoraria,
                      options: [220, 200, 180, 160],
                      onChanged: bloc.setCargaHoraria,
                      icon: Icon(Icons.list),
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
