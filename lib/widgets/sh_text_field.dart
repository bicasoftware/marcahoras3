import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/colors.dart';

class ShTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final EdgeInsets? padding;
  final String? Function(String?)? validator;
  final TextStyle? labelStyle;
  final bool isOutlined;
  final Icon? icon;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int? maxChars;
  final ValueChanged<String>? onValueChanged;

  const ShTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.label,
    this.labelStyle,
    this.validator,
    this.icon,
    this.inputFormatters,
    this.keyboardType,
    this.maxChars,
    this.onValueChanged,
    this.padding = EdgeInsets.zero,
    this.isOutlined = true,
  });

  get _inputBorder => UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black12, width: 1),
      );

  InputDecoration outlinedDecoration(TextTheme theme) => InputDecoration(
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.outline),
        ),
        hintText: hint,
        errorStyle: theme.labelLarge?.copyWith(
          color: AppColors.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      );
  InputDecoration defaultDecoration(TextTheme theme) => InputDecoration(
        filled: true,
        hintText: hint,
        border: _inputBorder,
        focusedBorder: _inputBorder,
        errorBorder: _inputBorder,
        enabledBorder: _inputBorder,
        disabledBorder: _inputBorder,
        focusedErrorBorder: _inputBorder,
        contentPadding: EdgeInsets.zero,
        icon: icon,
        errorStyle: theme.labelMedium?.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          label,
          style: labelStyle ??
              theme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          autofocus: false,
          decoration:
              isOutlined ? outlinedDecoration(theme) : defaultDecoration(theme),
          validator: validator,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          maxLength: maxChars,
          onChanged: onValueChanged,
        ),
      ],
    );
  }
}
