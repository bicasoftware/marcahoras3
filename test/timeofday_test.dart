import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/utils/extensions.dart';

void main() {
  test('should get minutes', () {
    final from = TimeOfDay(hour: 10, minute: 20);
    final to = TimeOfDay(hour: 11, minute: 40);

    final minutes = TimeOfDayHelper.getMinutesBetweenTimes(from, to);
    assert(minutes == 120);
  });

  test('should transforte minutes into timeofday', () {
    final TimeOfDay time = TimeOfDayHelper.getTimeOfDayFromMinutes(130);
    assert(time == TimeOfDay(hour: 2, minute: 10));
  });
}
