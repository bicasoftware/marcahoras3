import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/presentation_layer/blocs/empregos/empregos_detail/empregos_detail_bloc.dart';

import '../../presentation_layer/validators/validators.dart';
import '../../resources.dart';
import '../../utils/utils.dart';
import '../../widgets.dart';
import '../../widgets/dialogs/time_picker_dialog.dart';

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
  late final EmpregosDetailBloc _bloc;
  final _formKey = GlobalKey<FormState>();
  final ctrDescricao = TextEditingController();
  final ctrSalarioMasked = MoneyMaskedTextController(leftSymbol: "R\$");

  @override
  void dispose() {
    ctrDescricao.dispose();
    ctrSalarioMasked.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<EmpregosDetailBloc>().reset();
      ctrDescricao.addListener(_updateDescricao);
      ctrSalarioMasked.addListener(_updateSalario);
    }
  }

  void _updateSalario() => _bloc.setSalario(ctrSalarioMasked.numberValue);

  void _updateDescricao() => _bloc.setDescricao(ctrDescricao.text);

  Future<void> _selectDate(
    BuildContext context,
    EmpregosDetailBloc bloc,
  ) async {
    final date = await datePickerDialog(context, bloc.state.admissao);
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
        print("valid");
      } else {
        print('invalid on bloc');
      }
    } else {
      print('invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    _bloc = context.watch<EmpregosDetailBloc>();
    final textTheme = Theme.of(context).textTheme;
    final state = _bloc.state;
    final locale = Localizations.localeOf(context);

    return Scaffold(
      appBar: ShAppBar(
        label:
            widget.isInsert ? strings.adicionarEmprego : strings.editarEmprego,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: OutlinedButton.icon(
          onPressed: () => _validate(_bloc),
          icon: Icon(Icons.save_outlined),
          label: Text(
            strings.salvar,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 4),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ShTextTile(
                  controller: ctrDescricao,
                  label: "Descrição do Cargo",
                  hint: strings.descricaoEmprego,
                  labelStyle: textTheme.labelLarge,
                  icon: Icon(Icons.text_fields),
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
                  onTap: () => _selectDate(context, _bloc),
                  icon: Icons.calendar_month,
                ),
                const SizedBox(height: 8),
                ShTextTile(
                  controller: ctrSalarioMasked,
                  label: strings.salario,
                  hint: "R\$ 1000,00",
                  labelStyle: textTheme.labelLarge,
                  icon: Icon(Icons.monetization_on),
                  validator: (s) {
                    return MinCharactersValidator.validate(
                      ctrDescricao.text,
                      6,
                      strings,
                    );
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                ShLabeledTile(
                  value: state.entrada?.asString() ?? '09:00',
                  label: "Horário Entrada",
                  icon: Icons.timelapse_outlined,
                  onTap: () => _selectTime(
                    context: context,
                    bloc: _bloc,
                    isEntrada: true,
                  ),
                ),
                const SizedBox(height: 8),
                ShLabeledTile(
                  value: _bloc.state.saida?.asString() ?? "10:00",
                  label: "Horário Saída",
                  icon: Icons.timelapse_outlined,
                  onTap: () => _selectTime(
                    context: context,
                    bloc: _bloc,
                  ),
                ),
                const SizedBox(height: 8),
                ShDropDownButton(
                  label: strings.cargaHoraria,
                  value: state.cargaHoraria,
                  options: [160, 180, 200, 220],
                  onChanged: _bloc.setCargaHoraria,
                  icon: Icon(Icons.list),
                ),
                const SizedBox(height: 8),
                ShSwitchTile(
                  value: state.bancoHoras,
                  label: strings.bancoHoras,
                  onTap: (_) => _bloc.toggleBancoHoras(),
                ),
                const SizedBox(height: 8),
                ShSliderPicker(
                  label: "Porcentagem Dias Normais",
                  value: state.porcNormal ?? 50,
                  onChanged: _bloc.setPorcNormal,
                  minValue: 50,
                  maxValue: 250,
                ),
                const SizedBox(height: 8),
                ShSliderPicker(
                  label: "Porcentagem Feriados/Domingos",
                  value: state.porcFeriado ?? 100,
                  onChanged: _bloc.setPorcFeriados,
                  minValue: 100,
                  maxValue: 300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
