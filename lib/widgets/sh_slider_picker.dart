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
    final theme = Theme.of(context).textTheme;
    return IndicatorTile(
      child: ListTile(
        title: Row(
          children: [
            Text(label, style: theme.labelLarge),
            const Spacer(),
            Text(
              "${value.toString()} %",
              style: theme.labelLarge!.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
}
