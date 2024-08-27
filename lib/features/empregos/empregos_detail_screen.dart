import 'package:flutter/material.dart';
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
  final _formKey = GlobalKey<FormState>();
  final ctrDescricao = TextEditingController();
  final ctrSalario = TextEditingController();

  @override
  void dispose() {
    ctrDescricao.dispose();
    ctrSalario.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<EmpregosDetailBloc>().reset();
    }
  }

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

  void _setCargaHoraria(EmpregosDetailBloc bloc, String carga) {
    bloc.setCargaHoraria(int.parse(carga));
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final bloc = context.watch<EmpregosDetailBloc>();
    final textTheme = Theme.of(context).textTheme;
    final state = bloc.state;

    return Scaffold(
      appBar: ShAppBar(
        label:
            widget.isInsert ? strings.adicionarEmprego : strings.editarEmprego,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: OutlinedButton.icon(
          onPressed: () {},
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
                  label: strings.emprego,
                  hint: strings.descricaoEmprego,
                  labelStyle: textTheme.labelLarge,
                  validator: (s) {
                    return MinCharactersValidator.validate(
                      ctrDescricao.text,
                      6,
                      strings,
                    );
                  },
                ),
                const SizedBox(height: 8),
                ShToggleOptions(
                  items: ["160", "180", "200", "220"],
                  selectedItem: state.cargaHoraria.toString(),
                  onChanged: (c) => _setCargaHoraria(bloc, c),
                ),
                const SizedBox(height: 8),
                ShLabeledTile(
                  value: state.admissao?.toIso8601String() ?? '',
                  label: "Data Admissão",
                  onTap: () => _selectDate(context, bloc),
                  icon: Icons.calendar_month,
                ),
                const SizedBox(height: 8),
                ShTextTile(
                  controller: ctrSalario,
                  label: strings.salario,
                  hint: "R\$ 1000,00",
                  labelStyle: textTheme.labelLarge,
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
    );
  }
}
