import 'package:flutter/material.dart';

import '../../utils.dart';
import '../../widgets.dart';

class LabelFormField<T> extends StatelessWidget {
  final String label;
  final T initialValue;
  final String Function(T) valueFormatter;
  final EdgeInsets? padding;
  final Widget? trailing;
  final VoidCallback onTap;
  final String? Function(T?)? validator;
  final AutovalidateMode? autovalidateMode;

  final IconData icon;
  final Color themeColor;

  const LabelFormField({
    required this.label,
    required this.initialValue,
    required this.valueFormatter,
    required this.icon,
    required this.themeColor,
    this.padding = const .symmetric(horizontal: 16, vertical: 8),
    this.trailing,
    required this.onTap,
    this.validator,
    this.autovalidateMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ShFormItem(
      labelId: label,
      padding: padding,
      icon: icon,
      themeColor: themeColor,
      onTap: onTap,
      child: Text(
        valueFormatter(initialValue),
        style: context.textTheme.labelLarge?.copyWith(
          color: colors.onSurfaceVariant,
        ),
      ),
    );    
  }
}
