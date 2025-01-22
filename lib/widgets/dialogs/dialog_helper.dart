import 'package:flutter/material.dart';

import 'time_picker_dialog.dart';

class DialogHelper {
  static Future<DateTime?> showDateTimeDialog({
    required BuildContext context,
    required DateTime initDate,
    DateTime? admissao,
    bool allowFutureDates = false,
  }) async {
    final date = await datePickerDialog(
      context: context,
      admissao: admissao,
      initialDate: initDate,
      allowFutureDate: allowFutureDates,
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
