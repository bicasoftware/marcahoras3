import 'package:flutter/material.dart';
import 'package:marcahoras3/resources.dart';

import '../widgets.dart';

class ShSliderPicker extends StatelessWidget {
  final String label;
  final int value;
  final int maxValue;
  final int minValue;
  final ValueChanged<int> onChanged;

  const ShSliderPicker({
    required this.label,
    required this.value,
    required this.onChanged,
    this.minValue = 30,
    this.maxValue = 300,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IndicatorTile(
      child: ListTile(
        title: Text(label),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("${value.toString()} %"),
            Slider(
              min: minValue.toDouble(),
              max: maxValue.toDouble(),
              divisions: (maxValue - minValue) ~/ 5,
              value: value.toDouble(),
              label: value.toInt().toString(),
              activeColor: AppColors.primary,
              onChanged: (v) => onChanged(
                v.toInt(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
