import 'package:flutter/material.dart';

extension TimeOfDayHelper on TimeOfDay {
  String asString() {
    return "$hour:$minute";
  }
}

extension TimeOfDayToStringHelper on String {
  TimeOfDay toTimeOfDay() {
    final values = split(':').map((it) => int.tryParse(it) ?? 0).toList();
    return TimeOfDay(hour: values.first, minute: values.last);
  }
}
