import 'package:flutter/material.dart';

import '../../utils.dart';
import '../../widgets.dart';

class ShFormSlider extends StatelessWidget {
  final String labelId;
  final int value;
  final int maxValue;
  final int minValue;
  final ValueChanged<int> onChanged;
  final Color themeColor;
  final EdgeInsets? padding;

  const ShFormSlider({
    required this.labelId,
    required this.value,
    required this.onChanged,
    required this.themeColor,
    this.minValue = 30,
    this.maxValue = 300,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShFormItem(
      labelId: labelId,
      icon: Icons.percent,
      themeColor: themeColor,
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Slider(
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
          Text(
            "${value.toString()} %",
            style: context.textTheme.labelLarge!.copyWith(
              color: context.colors.primary,
              fontWeight: .bold,
            ),
          ),
        ],
      ),
    );
  }
}
