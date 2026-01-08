import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils.dart';

class ShTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final EdgeInsets? padding;
  final String? Function(String?)? validator;
  final TextStyle? labelStyle;
  final Icon? icon;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int? maxChars;
  final ValueChanged<String>? onValueChanged;

  const ShTextField({
    super.key,
    required this.controller,
    this.hint,
    this.label,
    this.labelStyle,
    this.validator,
    this.icon,
    this.inputFormatters,
    this.keyboardType,
    this.maxChars,
    this.onValueChanged,
    this.padding = EdgeInsets.zero,
  });

  InputDecoration defaultDecoration(BuildContext ctx) {
    final _inputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: ctx.colors.onSurface, width: 1),
    );

    return InputDecoration(
      hintText: hint,
      border: _inputBorder,
      focusedBorder: _inputBorder,
      errorBorder: _inputBorder,
      enabledBorder: _inputBorder,
      disabledBorder: _inputBorder,
      focusedErrorBorder: _inputBorder,
      contentPadding: .zero,
      icon: icon,
      errorStyle: ctx.textTheme.labelMedium?.copyWith(
        color: ctx.colors.error,
        fontWeight: .bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (label?.isNotEmpty ?? false)
          Text(
            label!,
            style:
                labelStyle ??
                context.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          autofocus: false,
          decoration: defaultDecoration(context),
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
