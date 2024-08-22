import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/bloc_loader.dart';
import 'package:marcahoras3/presentation_layer/blocs.dart';
import 'package:marcahoras3/presentation_layer/blocs/empregos/empregos_detail/empregos_detail_bloc.dart';
import '../../domain_layer/models.dart';
import '../../presentation_layer/validators/validators.dart';
import '../../resources.dart';
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
  final ctrAdmissao = TextEditingController();
  final ctrEntrada = TextEditingController();
  final ctrSaida = TextEditingController();

  @override
  void dispose() {
    ctrDescricao.dispose();
    ctrAdmissao.dispose();
    ctrEntrada.dispose();
    ctrSaida.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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

  void _setCargaHoraria(EmpregosDetailBloc bloc, int carga) {
    bloc.setCargaHoraria(carga);
  }

  void _setPorc(EmpregosDetailBloc bloc, int porc, String tipo) {
    tipo == 'n' ? bloc.setPorcNormal(porc) : bloc.setPorcFeriados(porc);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final bloc = context.read<EmpregosDetailBloc>();
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: HrAppBar(
        label:
            widget.isInsert ? strings.adicionarEmprego : strings.editarEmprego,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                HrTextInput(
                  controller: ctrDescricao,
                  label: strings.emprego,
                  hint: strings.descricaoEmprego,
                  labelStyle: theme.labelLarge!.copyWith(color: Colors.black),                  
                  validator: (s) {
                    return MinCharactersValidator.validate(
                      ctrDescricao.text,
                      6,
                      strings,
                    );
                  },
                ),
                HrClickableTextInput(
                  controller: ctrAdmissao,
                  label: "Data Admissão",
                  hint: "01/01/2020",
                  labelStyle: theme.labelLarge!.copyWith(color: Colors.black),
                  onTap: () => _selectDate(context, bloc),
                  validator: (s) {
                    return MinCharactersValidator.validate(
                      s,
                      10,
                      strings,
                    );
                  },
                ),
                HrClickableTextInput(
                  controller: ctrEntrada,
                  label: "Horário Entrada",
                  hint: "09:00",
                  labelStyle: theme.labelLarge!.copyWith(color: Colors.black),
                  onTap: () => _selectTime(
                    context: context,
                    bloc: bloc,
                    isEntrada: true,
                  ),
                  validator: (s) {
                    return MinCharactersValidator.validate(
                      s,
                      10,
                      strings,
                    );
                  },
                ),
                HrClickableTextInput(
                  controller: ctrEntrada,
                  label: "Horário Saída",
                  hint: "18:00",
                  labelStyle: theme.labelLarge!.copyWith(color: Colors.black),
                  onTap: () => _selectTime(
                    context: context,
                    bloc: bloc,
                  ),
                  validator: (s) {
                    return MinCharactersValidator.validate(
                      s,
                      10,
                      strings,
                    );
                  },
                ),                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
