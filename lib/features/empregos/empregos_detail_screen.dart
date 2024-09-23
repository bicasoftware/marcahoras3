import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/features/empregos/salarios_action_type.dart';

import '../../domain_layer/models.dart';
import '../../presentation_layer/blocs.dart';
import '../../presentation_layer/validators/validators.dart';
import '../../resources.dart';
import '../../utils/utils.dart';
import '../../widgets.dart';
import '../../widgets/dialogs/time_picker_dialog.dart';
import 'salarios_tile.dart';

class EmpregosDetailScreen extends StatefulWidget {
  final bool isInsert;

  const EmpregosDetailScreen({
    super.key,
    this.isInsert = true,
  });

  @override
  State<EmpregosDetailScreen> createState() => _EmpregosDetailScreenState();
}

class _EmpregosDetailScreenState extends State<EmpregosDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final ctrDescricao = TextEditingController();
  final ctrSalarioMasked =
      MoneyMaskedTextController(leftSymbol: "R\$", initialValue: 0.0);

  late final Empregos editableEmprego;

  @override
  void dispose() {
    ctrDescricao.dispose();
    ctrSalarioMasked.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final bloc = context.read<EmpregosDetailBloc>();
    ctrDescricao.text = bloc.state.descricao ?? '';
    ctrSalarioMasked.text = bloc.state.salario.toString();
    super.initState();
  }

  Future<void> _selectDate(
    BuildContext context,
    EmpregosDetailBloc bloc,
  ) async {
    final date = await datePickerDialog(
      context: context,
      initialDate: bloc.state.admissao,
      allowFutureDate: false,
    );
    if (date != null && date != bloc.state.admissao) {
      bloc.setAdmissao(date);
    }
  }

  Future<void> _selectTime({
    required BuildContext context,
    required EmpregosDetailBloc bloc,
    bool isEntrada = false,
  }) async {
    final initValue = isEntrada ? bloc.state.entrada : bloc.state.saida;
    final picked = await timePickerDialog(
      context: context,
      time: initValue,
    );

    if (picked != null && picked != initValue) {
      isEntrada ? bloc.setEntrada(picked) : bloc.setSaida(picked);
    }
  }

  Future<void> _validate(EmpregosDetailBloc bloc) async {
    final valid = _formKey.currentState?.validate() ?? false;
    if (valid) {
      if (bloc.validate()) {
        showLoadingDialog(context: context);
        final newEmprego = await bloc.save();
        final empregosBloc = await context.read<EmpregosBloc>();
        empregosBloc.addEmprego(newEmprego!);
        Navigator.of(context).pop(); // should pop the awaiting dialog
        Navigator.of(context)
            .pop(newEmprego); // pop the screen and returns a [Emprego] instance
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final bloc = context.watch<EmpregosDetailBloc>();
    final textTheme = Theme.of(context).textTheme;
    final state = bloc.state;
    final locale = Localizations.localeOf(context);

    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        appBar: ShAppBar(
          label: widget.isInsert
              ? strings.adicionarEmprego
              : strings.editarEmprego,
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: OutlinedButton.icon(
            onPressed: () => _validate(bloc),
            icon: Icon(Icons.save_outlined),
            label: Text(
              strings.salvar,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 4),
          child: SingleChildScrollView(
            child: BlocHelper<EmpregosDetailBloc, EmpregosDetailState>(
              bloc: bloc,
              onError: (error) {
                context.showSnackBar(error);
              },
              child: Form(
                key: _formKey,
                child: BlocHelper<EmpregosDetailBloc, EmpregosDetailState>(
                  bloc: bloc,
                  onError: (err) async {
                    showErrorDialog(context: context, errorMsg: err);
                    Navigator.of(context).pop();
                  },
                  child: Column(
                    children: [
                      ShTextTile(
                        controller: ctrDescricao,
                        label: "Descrição do Cargo",
                        hint: strings.descricaoEmprego,
                        labelStyle: textTheme.labelLarge,
                        icon: Icon(Icons.text_fields),
                        onValueChanged: bloc.setDescricao,
                        validator: (s) {
                          return MinCharactersValidator.validate(
                            ctrDescricao.text,
                            6,
                            strings,
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      ShLabeledTile(
                        value: formatDateByLocale(
                          state.admissao ?? DateTime.now(),
                          locale,
                        ),
                        label: "Data Admissão",
                        onTap: () => _selectDate(context, bloc),
                        icon: Icons.calendar_month,
                      ),
                      const SizedBox(height: 8),
                      SalariosTile(
                        isEditing: state.isEditing,
                        salarios: state.salarios,
                        onOptionSelected: (SalariosActionType value) {
                          /// TODO - Mostrar BTS com number input pra salarios e para vigencia
                          print(value);
                        },
                        controller: ctrSalarioMasked,
                        onSalarioValueChanged: (_) {
                          bloc.setSalario(ctrSalarioMasked.numberValue);
                        },
                      ),
                      const SizedBox(height: 8),
                      ShLabeledTile(
                        value: state.entrada?.asString() ?? '09:00',
                        label: "Horário Entrada",
                        icon: Icons.timelapse_outlined,
                        onTap: () => _selectTime(
                          context: context,
                          bloc: bloc,
                          isEntrada: true,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ShLabeledTile(
                        value: bloc.state.saida?.asString() ?? "10:00",
                        label: "Horário Saída",
                        icon: Icons.timelapse_outlined,
                        onTap: () => _selectTime(
                          context: context,
                          bloc: bloc,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ShDropDownButton(
                        label: strings.cargaHoraria,
                        value: state.cargaHoraria,
                        options: [160, 180, 200, 220],
                        onChanged: bloc.setCargaHoraria,
                        icon: Icon(Icons.list),
                      ),
                      const SizedBox(height: 8),
                      ShSwitchTile(
                        value: state.bancoHoras,
                        label: strings.bancoHoras,
                        onTap: (_) => bloc.toggleBancoHoras(),
                      ),
                      const SizedBox(height: 8),
                      ShSliderPicker(
                        label: "Porcentagem Dias Normais",
                        value: state.porcNormal ?? 50,
                        onChanged: bloc.setPorcNormal,
                        minValue: 50,
                        maxValue: 250,
                      ),
                      const SizedBox(height: 8),
                      ShSliderPicker(
                        label: "Porcentagem Feriados/Domingos",
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
      ),
    );
  }
}
