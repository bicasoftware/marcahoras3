import 'package:flutter/material.dart';

import '../utils.dart';
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
        title: Row(
          children: [
            Text(label, style: context.textTheme.labelLarge),
            const Spacer(),
            Text(
              "${value.toString()} %",
              style: context.textTheme.labelLarge!.copyWith(
                color: context.colors.onSurface,
                fontWeight: .bold,
              ),
            ),
          ],
        ),
        subtitle: Slider(
          min: minValue.toDouble(),
          max: maxValue.toDouble(),
          divisions: (maxValue - minValue) ~/ 5,
          value: value.toDouble(),
          label: value.toInt().toString(),
          onChanged: (v) => onChanged(
            v.toInt(),
          ),
          activeColor: context.colors.secondary,
        ),
      ),
    );
  }
}
