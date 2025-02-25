import 'package:flutter/material.dart';

import '../../utils.dart';

Future<void> showErrorDialog({
  required BuildContext context,
  required String errorMsg,
}) async {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(Localiza.find('defaultErro')),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(Localiza.find('fechar')),
          ),
        ],
        content: Container(
          padding: const EdgeInsets.all(16),
          child: Text(errorMsg),
        ),
      );
    },
  );
}
