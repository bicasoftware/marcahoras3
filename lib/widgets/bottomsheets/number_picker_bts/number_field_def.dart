import 'package:flutter/foundation.dart';

@immutable
class NumberFieldDef {
  final int maxLength;
  final String label;
  final int min, max, step, initialValue;

  NumberFieldDef({
    required this.maxLength,
    required this.label,
    required this.min,
    required this.max,
    required this.initialValue,
    this.step = 1,
  });
}
