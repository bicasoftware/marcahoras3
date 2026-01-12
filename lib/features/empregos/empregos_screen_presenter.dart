import 'package:flutter/material.dart';

import '../../dialogs.dart';
import '../../domain_layer/models.dart';
import '../../presentation_layer/blocs.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'empregos_screen.dart';
import 'porcentagens/valor_fixo/valor_fixo_bts.dart';
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

  void showDiaFechamentoPicker({
    required BuildContext context,
    required EmpregosBloc bloc,
    required int day,
  }) async {
    final newDay = await showScrollableDayPickerDialog(
      context: context,
      titleMsgKey: 'selecionarDiaFechamento',
      day: bloc.state.emprego.diaFechamento,
    );

    if (newDay != null) {
      bloc.setDiaFechamento(newDay);
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

          Navigator.of(context).pop();
        },
      ),
    );
  }

  Future<void> _showValorFixoBts({
    required EmpregosBloc bloc,
    required bool isInsert,
    HoraFixo? horaFixo,
  }) async {
    await BottomSheetHelper.showModalBts(
      context: context,
      dismissible: true,
      showDragHandle: false,
      body: ValorFixoBts(
        isInsert: isInsert,
        valorFixo: horaFixo?.toValorFixo() ?? (0, 0),
        vigencia: DateTime.now(),
        onSave: (valorFixo, vigencia) async {
          showLoadingDialog(context: context);
          if (isInsert) {
            await bloc.insertHoraFixo(
              valorFixo: valorFixo,
              vigencia: vigencia,
              empregoId: bloc.state.emprego.id!,
            );
          } else {
            await bloc.updateHoraFixo(
              horaFixo!.copyWith(
                valorNormal: valorFixo.$1,
                valorFeriado: valorFixo.$2,
                vigencia: vigencia,
              ),
            );
          }

          Navigator.of(context).pop();
        },
      ),
    );
  }

  Future<void> insertHoraFixo(EmpregosBloc bloc) async {
    return await _showValorFixoBts(
      bloc: bloc,
      isInsert: true,
    );
  }

  Future<void> updateHoraFixo(EmpregosBloc bloc, HoraFixo horaFixo) async {
    return await _showValorFixoBts(
      bloc: bloc,
      isInsert: false,
      horaFixo: horaFixo,
    );
  }

  void deleteHoraFixo(EmpregosBloc bloc, HoraFixo horaFixo) async {
    final shouldDelete = await showConfirmationDialog(
      context: context,
      titleMsg: Localiza.findAndReplace(
        stringKey: 'deleteDialogTitle',
        findString: '{value}',
        replaceWithKey: 'valorFixo',
      ),
      descriptionText: Localiza.findAndReplace(
        stringKey: 'deleteDialogMsg',
        findString: '{value}',
        replaceWithKey: 'valorFixo',
      ),
    );

    if (shouldDelete) {
      showLoadingDialog(context: context);

      await bloc.deleteHoraFixo(horaFixo);

      Navigator.of(context).pop();
    }
  }
}
