import 'package:flutter/material.dart';

import '../../utils.dart';

Future<void> showLoadingDialog({required BuildContext context}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(Localiza.find('carregando')),
          ],
        ),
      );
    },
  );
}
