import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets/dialogs/vigencia_picker_dialog_body.dart';

import '../../utils.dart';

Future<(int, int)?> showVigenciaPickerDialog({
  required BuildContext context,
  required String titleMsg,
  required String descriptionText,
  required int ano,
  required int mes,
  String? okLabel,
  String? cancelLabel,
  TimeOfDay? startAt,
  TimeOfDay? endAt,
}) async {
  (int, int)? vigencia;

  await showDialog<(int, int)?>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(titleMsg),
        actions: [
          TextButton(
            onPressed: () {
              vigencia = null;
              Navigator.of(context).pop(null);
            },
            child: Text(cancelLabel ?? Localiza.find('cancelar')),
          ),
          TextButton(
            child: Text(okLabel ?? Localiza.find('confirmar')),
            onPressed: () => Navigator.of(context).pop(vigencia),
          ),
        ],
        content: VigenciaPickerBody(
          ano: ano,
          mes: mes,
          onVigenciaSet: (v) => vigencia = v,
        ),
      );
    },
  );

  return vigencia;
}
