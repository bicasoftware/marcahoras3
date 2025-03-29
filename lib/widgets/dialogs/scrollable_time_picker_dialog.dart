import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets/dialogs/scrollable_time_picker.dart';

import '../../utils.dart';

Future<TimeOfDay?> showScrollableTimePickerDialog({
  required BuildContext context,
  required String titleMsg,
  required String descriptionText,
  required TimeOfDay timeOfDay,
  String? okLabel,
  String? cancelLabel,
  TimeOfDay? startAt,
  TimeOfDay? endAt,
}) async {
  TimeOfDay? response = timeOfDay;

  await showDialog<TimeOfDay?>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(titleMsg),
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
        content: ScrollableTimePickerBody(
          timeOfDay: timeOfDay,
          onTimeSet: (t) => response = t,
          startAt: startAt,
          endAt: TimeOfDay(hour: 23, minute: 59),
        ),
      );
    },
  );

  return response;
}
