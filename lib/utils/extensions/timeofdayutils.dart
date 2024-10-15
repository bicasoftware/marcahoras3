import 'package:flutter/material.dart';

extension TimeOfDayHelper on TimeOfDay {
  String asString() {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }

  TimeOfDay addHours(int amount) {
    return TimeOfDay(hour: hour + amount, minute: minute);
  }
}

extension TimeOfDayToStringHelper on String {
  TimeOfDay toTimeOfDay() {
    final values = split(':').map((it) => int.tryParse(it) ?? 0).toList();
    return TimeOfDay(hour: values[0], minute: values[1]);
  }
}

extension TimeOfDayToDateHelper on DateTime {
  TimeOfDay toTimeOfDay() {
    return TimeOfDay(hour: hour, minute: minute);
  }

  String toTimeStr() {
    return "$hour:$minute:00";
  }
}
