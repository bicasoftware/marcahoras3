import 'package:flutter/material.dart';
import '../../resources.dart';

Future<void> showLoadingDialog({
  required BuildContext context,
}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      final strings = context.strings();
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(strings.carregando),
          ],
        ),
      );
    },
  );
}
