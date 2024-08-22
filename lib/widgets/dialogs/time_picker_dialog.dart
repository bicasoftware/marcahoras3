import 'package:flutter/material.dart';

Future<DateTime?> datePickerDialog(
    BuildContext context, DateTime? initialDate) async {
  return await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
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
