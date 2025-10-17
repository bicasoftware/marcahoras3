import 'package:flutter/material.dart';

import '../../utils.dart';

Future<bool> showConfirmationDialog({
  required BuildContext context,
  required String titleMsg,
  required String descriptionText,
  String? okLabel,
  String? cancelLabel,
}) async {
  bool response = false;

  await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(titleMsg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              response = false;
            },
            child: Text(cancelLabel ?? Localiza.find('cancelar')),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              response = true;
            },
            child: Text(okLabel ?? Localiza.find('confirmar')),
          ),
        ],
        content: Container(
          padding: const EdgeInsets.all(16),
          child: Text(descriptionText),
        ),
      );
    },
  );

  return response;
}
