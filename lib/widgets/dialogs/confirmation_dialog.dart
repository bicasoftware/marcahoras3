import 'package:flutter/material.dart';

import '../../resources.dart';

Future<bool> showConfirmationDialog({
  required BuildContext context,
  required String titleMsg,
  required String descriptionText,
  String? okLabel,
  String? cancelLabel,
}) async {
  final strings = context.strings();
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
              response = true;
            },
            child: Text(okLabel ?? strings.confirmar),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(cancelLabel ?? strings.cancelar),
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
