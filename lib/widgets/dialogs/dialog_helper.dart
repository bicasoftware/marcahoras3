import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'time_picker_dialog.dart';

class DialogHelper {
  static Future<DateTime?> showDateTimeDialog(
    BuildContext context,
    DateTime initDate,
  ) async {
    final date = await datePickerDialog(
      context: context,
      initialDate: initDate,
      allowFutureDate: false,
    );

    return (date != null && date != initDate) ? date : null;
  }

  static Future<TimeOfDay?> showTimeDialog({
    required BuildContext context,
    required TimeOfDay time,
  }) async {
    final picked = await timePickerDialog(
      context: context,
      time: time,
    );

    return (picked != null && picked != time) ? picked : null;
  }
}
