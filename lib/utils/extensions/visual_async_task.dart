import 'package:flutter/widgets.dart';

import '../../utils.dart';
import '../../widgets.dart';

Future<void> awaitableTask({
  required BuildContext context,
  required Future<void> Function() actualTask,
  bool requireConfirmation = false,
  String confirmationTitle = '',
  String confirmationMessage = '',
  bool popWhenDone = true,
}) async {
  bool canProceed = true;

  if (requireConfirmation) {
    canProceed = await showConfirmationDialog(
      context: context,
      titleMsg:
          confirmationTitle.isEmpty
              ? Localiza.find('confirmar')
              : confirmationTitle,
      descriptionText: confirmationMessage,
    );
  }

  if (canProceed) {
    showLoadingDialog(context: context);
    await actualTask();

    if (popWhenDone) Navigator.of(context).pop();
  }
}
