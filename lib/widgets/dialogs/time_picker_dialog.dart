import 'package:flutter/material.dart';

Future<DateTime?> datePickerDialog({
  required BuildContext context,
  DateTime? admissao,
  DateTime? initialDate,
  DateTime? endDate,
}) async {
  return await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: admissao ?? DateTime(2020, 1, 1),
    lastDate: endDate ?? DateTime(2100, 12, 31),
  );
}

Future<TimeOfDay?> timePickerDialog({
  required BuildContext context,
  TimeOfDay? time,
}) async {
  return await showTimePicker(
    context: context,
    initialTime: time ?? TimeOfDay(hour: 09, minute: 09),
    initialEntryMode: TimePickerEntryMode.inputOnly,
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      );
    },
  );
}
