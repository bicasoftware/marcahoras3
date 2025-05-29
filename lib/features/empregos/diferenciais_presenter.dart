import 'package:flutter/material.dart';

import '../../domain_layer/models.dart';
import '../../presentation_layer/blocs.dart';
import '../../utils/localiza/localiza.dart';
import '../../widgets.dart';
import 'empregos_screen.dart';
import 'porcentagens/diferenciais/diff_bts.dart';

mixin DiferenciaisPresenterMixin on State<EmpregosScreen> {
  
  void onAddDiferencial(EmpregosBloc bloc) async {
    await BottomSheetHelper.showModalBts(
      context: context,
      body: DiffBts(
        porc: 50,
        weekDay: 0,
        onSave: (porc, weekDay) async {
          showLoadingDialog(context: context);

          await bloc.insertDiferencial(
            porc: porc,
            weekDay: weekDay,
            empregoId: bloc.state.emprego.id!,
          );

          Navigator.of(context).pop();
        },
      ),
    );
  }

  void onDeleteDiferencial(Diferenciais dife, EmpregosBloc bloc) async {
    final bool shouldDelete = await showConfirmationDialog(
      context: context,
      titleMsg: Localiza.findAndReplace(
        stringKey: 'deleteDialogTitle',
        findString: '{value}',
        replaceWithKey: 'diferencial',
      ),
      descriptionText: Localiza.findAndReplace(
        stringKey: 'deleteDialogMsg',
        findString: '{value}',
        replaceWithKey: 'diferencial',
      ),
    );

    if (shouldDelete) {
      showLoadingDialog(context: context);

      await bloc.deleteDiferenciais(dife);

      Navigator.of(context).pop();
    }
  }

  void onUpdateDiferencial(Diferenciais dife, EmpregosBloc bloc) async {
    await BottomSheetHelper.showModalBts(
      context: context,
      body: DiffBts(
        porc: dife.percentage,
        weekDay: dife.weekday,
        onSave: (porc, weekDay) async {
          showLoadingDialog(context: context);
          await bloc.updateDiferenciais(
            dife.copyWith(percentage: porc, weekday: weekDay),
          );

          Navigator.of(context).pop();
        },
      ),
    );
  }
}
