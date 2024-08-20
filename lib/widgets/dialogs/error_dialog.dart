import 'package:flutter/material.dart';

import '../../resources.dart';

Future<void> showErrorDialog({
  required BuildContext context,
  required String errorMsg,
}) async {
  final strings = context.strings();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(strings.defaultErro),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(strings.fechar),
          )
        ],
        content: Container(
          padding: const EdgeInsets.all(16),
          child: Text(errorMsg),
        ),
      );
    },
  );
}
