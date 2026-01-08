import 'package:flutter/material.dart';

import '../../utils.dart';
import '../../widgets.dart';

class LabelFormField<T> extends StatelessWidget {
  final String label;
  final T initialValue;
  final String Function(T) valueFormatter;
  final IconData? icon;
  final EdgeInsets? padding;
  final Widget? trailing;
  final VoidCallback onTap;
  final String? Function(T?)? validator;
  final AutovalidateMode? autovalidateMode;

  const LabelFormField({
    required this.label,
    required this.initialValue,
    required this.valueFormatter,
    this.icon,
    this.padding,
    this.trailing,
    required this.onTap,
    this.validator,
    this.autovalidateMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomizableFormField(
      label: label,
      child: ListTile(
        title: Text(label, style: context.textTheme.labelLarge),
        leading: Icon(icon, color: context.colors.secondary),
        contentPadding: padding,
        trailing: trailing,
        subtitle: Text(valueFormatter(initialValue)),
      ),
      onTap: onTap,
      validator: validator,
      autovalidateMode: autovalidateMode,
      padding: padding,
      icon: icon,
      trailing: trailing,
    );
  }
}
