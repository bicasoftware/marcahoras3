import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets/forms/customizable_form_field.dart';

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
    final theme = Theme.of(context).textTheme;

    return CustomizableFormField(
      label: label,
      child: ListTile(
        title: Text(label, style: theme.labelLarge),
        leading: Icon(icon),
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
