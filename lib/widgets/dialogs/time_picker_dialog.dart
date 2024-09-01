import 'package:flutter/material.dart';

Future<DateTime?> datePickerDialog({
  required BuildContext context,
  DateTime? initialDate,
  bool allowFutureDate = false,
}) async {
  return await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: allowFutureDate ? DateTime(2100) : DateTime.now(),
  );
}

Future<TimeOfDay?> timePickerDialog({
  required BuildContext context,
  TimeOfDay? time,
}) async {
  return await showTimePicker(
    context: context,
    initialTime: time ?? TimeOfDay(hour: 09, minute: 09),
  );
}
