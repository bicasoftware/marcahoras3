import 'package:flutter/material.dart';

import '../../dialogs.dart';
import '../../utils.dart';

Future<int?> showScrollableDayPickerDialog({
  required BuildContext context,
  required String titleMsgKey,
  required int day,
  String? okLabel,
  String? cancelLabel,
}) async {
  int? response = day;

  await showDialog<int?>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(Localiza.find(titleMsgKey)),
        actions: [
          TextButton(
            onPressed: () {
              response = null;
              Navigator.of(context).pop(null);
            },
            child: Text(cancelLabel ?? Localiza.find('cancelar')),
          ),
          TextButton(
            child: Text(okLabel ?? Localiza.find('confirmar')),
            onPressed: () {
              Navigator.of(context).pop(response);
            },
          ),
        ],
        content: ScrollableDayPickerBody(
          day: response!,
          onDaySet: (int t) => response = t,
        ),
      );
    },
  );

  return response;
}
