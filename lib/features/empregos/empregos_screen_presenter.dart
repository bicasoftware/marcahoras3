import 'package:flutter/material.dart';

import '../../dialogs.dart';
import '../../domain_layer/models.dart';
import '../../presentation_layer/blocs.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'empregos_screen.dart';
import 'salarios/salarios_detail_bts.dart';

mixin EmpregosScreenPresenterMixin on State<EmpregosScreen> {
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

  void handleAumento(EmpregosBloc bloc) async {
    await BottomSheetHelper.showModalBts(
      context: context,
      body: SalariosDetailBts(
        value: 0.0,
        vigencia: DateTime.now(),
        title: Localiza.find("addAumento"),
        onSave: (valor, vigencia) async {
          showLoadingDialog(context: context);

          bloc.addAumento(
            valor: valor,
            vigencia: vigencia,
          );

          Navigator.of(context).pop();
        },
      ),
    );
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

      bloc.deleteSalario(salario);

      Navigator.of(context).pop();
    }
  }

  void updateSalario(Salarios salario, EmpregosBloc bloc) async {
    await BottomSheetHelper.showModalBts(
      context: context,
      body: SalariosDetailBts(
        value: salario.valor,
        vigencia: parseVigencia(salario.vigencia),
        title: Localiza.find("editarSalario"),
        onSave: (valor, vigencia) async {
          showLoadingDialog(context: context);
          bloc.editSalario(
            original: salario,
            fresh: salario.copyWith(
              valor: valor,
              vigencia: vigencia,
            ),
          );

          Navigator.of(context).pop();
        },
      ),
    );
  }

  Future<void> validate(
    GlobalKey<FormState> formKey,
    EmpregosBloc bloc,
    HomeBloc homeBloc,
    bool popWhenDone,
  ) async {
    final valid = formKey.currentState?.validate() ?? false;
    if (valid) {
      if (bloc.validate()) {
        await awaitableTask(
          context: context,
          actualTask: () async {
            await bloc.persist();
            await homeBloc.load();
            Navigator.of(context).pop();
          },
          popWhenDone: popWhenDone,
        );
      }
    }
  }

  bool canPop({
    required GlobalKey<FormState> formKey,
    required Empregos ogEmprego,
    required EmpregosBloc bloc,
  }) {
    /// Sempre retorna false se for insert,
    /// Sempre retorna false se houve mudança de dados ao atualizar
    /// Assim, se for insert ou se o usuário tiver alterando algum dado
    /// e clicar em voltar, mostrar dialog confirmando alteração ou cancelar
    if(bloc.state.isInsert) {
      return false;
    } else {
      return !bloc.state.didChangeData(ogEmprego);
    }
  }
}
