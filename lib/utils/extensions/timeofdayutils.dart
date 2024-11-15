import 'package:flutter/material.dart';

class TimeOfDayHelper {
  static String formatTime(TimeOfDay time, [addSeconds = false]) {
    final tempo =
        "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";

    return addSeconds ? "$tempo:00" : tempo;
  }

  static TimeOfDay parseString(String timeStr) {
    final values =
        timeStr.split(':').map((it) => int.tryParse(it) ?? 0).toList();
    return TimeOfDay(hour: values[0], minute: values[1]);
  }

  static String formatTimeFromDate(DateTime date) {
    return "${date.hour}:${date.minute}:00";
  }

  static String formatTimeFromMinutes(int minutes) {
    final time = getTimeOfDayFromMinutes(minutes);
    return formatTime(time);
  }

  static TimeOfDay addHours(TimeOfDay time, int hours) {
    return TimeOfDay(hour: time.hour + hours, minute: time.minute);
  }

  static int getMinutesBetweenTimes(TimeOfDay from, TimeOfDay to) {
    final hours = (to.hour - from.hour) * 60;
    final minutes = to.minute + from.minute;
    return hours + minutes;
  }

  static TimeOfDay getTimeOfDayFromMinutes(int minutes) {
    final hours = minutes / 60;
    final minutesCalc = minutes % 60;

    return TimeOfDay(hour: hours.truncate(), minute: minutesCalc);
  }

  static TimeOfDay getTimeOfDayInRange(TimeOfDay from, TimeOfDay to) {
    final minutes = getMinutesBetweenTimes(from, to);

    return getTimeOfDayFromMinutes(minutes);
  }

  static String formatDayInRange(TimeOfDay from, TimeOfDay to) {
    return getTimeOfDayInRange(from, to).asString();
  }
}

extension TimeOfDayExt on TimeOfDay {
  String asString([addSeconds = false]) {
    final tempo =
        "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";

    return addSeconds ? "$tempo:00" : tempo;
  }
}
