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
import 'salarios/salarios_action_type.dart';
import 'salarios/salarios_detail_bts.dart';
import 'salarios/salarios_tile.dart';

class EmpregosScreen extends StatefulWidget {
  const EmpregosScreen();

  @override
  State<EmpregosScreen> createState() => _EmpregosScreenState();
}

class _EmpregosScreenState extends State<EmpregosScreen> {
  late final bool isInsert;
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
    var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
    ctrSalarioMasked = MoneyMaskedTextController(
      leftSymbol: format.currencySymbol,
      initialValue: bloc.state.salario,
    );

    super.initState();
  }

  Future<void> _selectDate(BuildContext context, EmpregosBloc bloc) async {
    final date = await DialogHelper.showDateTimeDialog(
      context: context,
      initDate: DateTime.now(),
      allowFutureDates: true,
    );

    if (date != null && date != bloc.state.admissao) {
      bloc.setAdmissao(date);
    }
  }

  Future<void> _selectTime({
    required BuildContext context,
    required EmpregosBloc bloc,
    bool isEntrada = false,
  }) async {
    final initValue = isEntrada ? bloc.state.entrada : bloc.state.saida;
    final picked = await DialogHelper.showTimeDialog(
      context: context,
      time: initValue!,
    );

    if (picked != null && picked != initValue) {
      isEntrada ? bloc.setEntrada(picked) : bloc.setSaida(picked);
    }
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

  void _deleteSalario(Salarios salario, EmpregosBloc bloc) async {
    final bool shouldDelete = await showConfirmationDialog(
      context: context,
      titleMsg: "Apagar Salário",
      descriptionText: "Você realmente deseja apagar o Salário?",
    );

    if (shouldDelete) {
      showLoadingDialog(context: context);

      await bloc.deleteSalario(salario: salario);

      // should pop the awaiting dialog
      Navigator.of(context).pop();
    }
  }

  void _updateSalario(Salarios salario, EmpregosBloc bloc) async {
    await BottomSheetHelper.showModalBts(
      context: context,
      body: SalariosDetailBts(
        value: salario.valor,
        vigencia: salario.vigencia,
        title: Localiza.find("editarSalario"),
        onSave: (valor, vigencia) async {
          showLoadingDialog(context: context);
          await bloc.updateSalario(
            salario.copyWith(valor: valor, vigencia: vigencia),
          );

          // should pop the awaiting dialog
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _handleAumento(SalariosActionType action, EmpregosBloc bloc) async {
    if (action == SalariosActionType.aumento) {
      await BottomSheetHelper.showModalBts(
        context: context,
        body: SalariosDetailBts(
          value: 0.0,
          vigencia: DateTime.now(),
          title: Localiza.find("addAumento"),
          onSave: (valor, vigencia) async {
            showLoadingDialog(context: context);

            await bloc.insertSalario(
              valor: valor,
              vigencia: vigencia,
              empregoId: bloc.state.emprego.id!,
            );

            Navigator.of(context).pop();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isInsert = ModalRoute.of(context)?.settings.arguments as bool;
    final bloc = context.watch<EmpregosBloc>();
    final textTheme = Theme.of(context).textTheme;
    final state = bloc.state;
    final locale = Localizations.localeOf(context);

    return Scaffold(
      appBar: ShAppBar(
        label:
            isInsert
                ? Localiza.find("adicionarEmprego")
                : Localiza.find("editarEmprego"),
        actions: [
          if (!isInsert)
            IconButton(icon: Icon(Icons.delete_outline), onPressed: () {}),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
        child: OutlinedButton.icon(
          onPressed: () => _validate(bloc),
          icon: Icon(Icons.save_outlined),
          label: Text(Localiza.find("salvar")),
        ),
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
                    const SizedBox(height: 8),
                    ShLabeledTile(
                      value: formatDateByLocale(
                        state.admissao ?? DateTime.now(),
                        locale,
                      ),
                      label: Localiza.find("admissao"),
                      onTap: () => _selectDate(context, bloc),
                      icon: Icons.calendar_month,
                    ),
                    const SizedBox(height: 8),
                    SalariosTile(
                      controller: ctrSalarioMasked,
                      isEditing: bloc.state.isEditing,
                      salarios: state.emprego.salarios,
                      onOptionSelected: (action) {
                        _handleAumento(action, bloc);
                      },
                      onSalarioValueChanged: (_) {
                        bloc.setSalario(ctrSalarioMasked.numberValue);
                      },
                      onEdit: (s) => _updateSalario(s, bloc),
                      onDelete: (s) => _deleteSalario(s, bloc),
                    ),
                    const SizedBox(height: 8),
                    ShLabeledTile(
                      value: TimeOfDayHelper.formatTime(state.entrada!),
                      label: Localiza.find("entradaHora"),
                      icon: Icons.timelapse_outlined,
                      onTap:
                          () => _selectTime(
                            context: context,
                            bloc: bloc,
                            isEntrada: true,
                          ),
                    ),
                    const SizedBox(height: 8),
                    ShLabeledTile(
                      value: TimeOfDayHelper.formatTime(bloc.state.saida!),
                      label: Localiza.find("saidaHora"),
                      icon: Icons.timelapse_outlined,
                      onTap: () => _selectTime(context: context, bloc: bloc),
                    ),
                    const SizedBox(height: 8),
                    ShDropDownButton(
                      label: Localiza.find("cargaHoraria"),
                      value: state.cargaHoraria,
                      options: [160, 180, 200, 220],
                      onChanged: bloc.setCargaHoraria,
                      icon: Icon(Icons.list),
                    ),
                    const SizedBox(height: 8),
                    ShSwitchTile(
                      value: state.bancoHoras,
                      label: Localiza.find("bancoHoras"),
                      onTap: (_) => bloc.toggleBancoHoras(),
                    ),
                    const SizedBox(height: 8),
                    ShSliderPicker(
                      label: Localiza.find("porcNormal"),
                      value: state.porcNormal ?? 50,
                      onChanged: bloc.setPorcNormal,
                      minValue: 50,
                      maxValue: 250,
                    ),
                    const SizedBox(height: 8),
                    ShSliderPicker(
                      label: Localiza.find("porcFeriado"),
                      value: state.porcFeriado ?? 100,
                      onChanged: bloc.setPorcFeriados,
                      minValue: 100,
                      maxValue: 300,
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
