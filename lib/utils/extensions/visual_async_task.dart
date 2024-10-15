import 'package:flutter/widgets.dart';
import 'package:marcahoras3/resources.dart';
import 'package:marcahoras3/widgets/dialogs/confirmation_dialog.dart';

import '../../widgets/dialogs/loading_dialog.dart';

Future<void> awaitableTask({
  required BuildContext context,
  required Future<void> Function() actualTask,
  bool requireConfirmation = false,
  String confirmationTitle = '',
  String confirmationMessage = '',
  bool popWhenDone = true,
}) async {
  bool canProceed = true;
  final strings = context.strings();

  if (requireConfirmation) {
    canProceed = await showConfirmationDialog(
      context: context,
      titleMsg:
          confirmationTitle.isEmpty ? strings.confirmar : confirmationTitle,
      descriptionText: confirmationMessage,
    );
  }

  if (canProceed) {
    showLoadingDialog(context: context);
    await actualTask();

    if (popWhenDone) Navigator.of(context).pop();
  }
}
