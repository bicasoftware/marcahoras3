import 'package:flutter/material.dart';
import 'package:marcahoras3/features/empregos/porcentagens/valor_fixo/valor_fixo_bts.dart';
import 'package:marcahoras3/widgets/dialogs/scrollable_time_picker_dialog.dart';

import '../../domain_layer/models.dart';
import '../../presentation_layer/blocs.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'empregos_screen.dart';
import 'salarios/salarios_action_type.dart';
import 'salarios/salarios_detail_bts.dart';

mixin EmpregosScreenPresenterMixin on State<EmpregosScreen> {
  var _tapPosition = Offset.zero;

  Future<void> selectDate(BuildContext context, EmpregosBloc bloc) async {
    final date = await DialogHelper.showDateTimeDialog(
      context: context,
      initDate: DateTime.now(),
      allowFutureDates: true,
    );

    if (date != null && date != bloc.state.admissao) {
      bloc.setAdmissao(date);
    }
  }

  void showHorasBts({
    required BuildContext context,
    required EmpregosBloc bloc,
    required TimeOfDay time,
    required bool isEntrada,
  }) async {
    final newTime = await showScrollableTimePickerDialog(
      context: context,
      titleMsg: Localiza.find('selecionarHorario'),
      descriptionText: '',
      timeOfDay: time,
    );

    if (newTime != null && newTime != time) {
      isEntrada ? bloc.setEntrada(newTime) : bloc.setSaida(newTime);
    }
  }

  void handleAumento(SalariosActionType action, EmpregosBloc bloc) async {
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

  void deleteSalario(Salarios salario, EmpregosBloc bloc) async {
    final bool shouldDelete = await showConfirmationDialog(
      context: context,
      titleMsg: Localiza.findAndReplace(
        stringKey: 'deleteDialogTitle',
        findString: '{value}',
        replaceWithKey: 'salario',
      ),
      descriptionText: Localiza.findAndReplace(
        stringKey: 'deleteDialogMsg',
        findString: '{value}',
        replaceWithKey: 'salario',
      ),
    );

    if (shouldDelete) {
      showLoadingDialog(context: context);

      await bloc.deleteSalario(salario: salario);

      // should pop the awaiting dialog
      Navigator.of(context).pop();
    }
  }

  void updateSalario(Salarios salario, EmpregosBloc bloc) async {
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

  void showValorFixoBts(EmpregosBloc bloc) async {
    await BottomSheetHelper.showModalBts(
      context: context,
      dismissible: true,
      showDragHandle: false,
      body: ValorFixoBts(
        valorFixo: bloc.state.getCurrentValorFixo(),
        vigencia: DateTime.now(),
        onSave: (valorFixo, vigencia) async {
          awaitableTask(
            context: context,
            popWhenDone: true,
            actualTask:
                () => bloc.insertHoraFixo(
                  valorFixo: valorFixo,
                  vigencia: vigencia,
                  empregoId: bloc.state.emprego.id!,
                ),
          );
        },
      ),
    );
  }
}
