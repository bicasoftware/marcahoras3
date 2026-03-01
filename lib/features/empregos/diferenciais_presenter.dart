import 'package:flutter/material.dart';

import '../../domain_layer/models.dart';
import '../../presentation_layer/blocs/empregos/empregos_bloc.dart';
import '../../resources.dart';
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
        color: ExtraColors.porcDiferenciadaColor,
        onSave: (int porc, int weekDay, Color color) async {
          showLoadingDialog(context: context);

          bloc.addDiferenciada(
            porc: porc,
            weekDay: weekDay,
            color: color,
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

      bloc.deleteDiferenciada(dife);

      Navigator.of(context).pop();
    }
  }

  void onUpdateDiferencial(Diferenciais dife, EmpregosBloc bloc) async {
    await BottomSheetHelper.showModalBts(
      context: context,
      body: DiffBts(
        porc: dife.percentage,
        weekDay: dife.weekday,
        color: dife.color,
        onSave: (porc, weekDay, color) async {
          showLoadingDialog(context: context);
          bloc.editDiferenciada(
            original: dife,
            fresh: dife.copyWith(
              percentage: porc,
              weekday: weekDay,
              color: color,
            ),
          );

          Navigator.of(context).pop();
        },
      ),
    );
  }
}
