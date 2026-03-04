import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets.dart';

class ShTextTile extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final TextStyle? labelStyle;
  final IconData icon;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int? maxChars;
  final ValueChanged<String>? onValueChanged;
  final EdgeInsets? padding;

  final Color themeColor;

  const ShTextTile({
    required this.controller,
    required this.label,
    required this.hint,
    required this.themeColor,
    required this.icon,
    this.validator,
    this.labelStyle,
    this.keyboardType,
    this.inputFormatters,
    this.maxChars,
    this.onValueChanged,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShFormItem(
      labelId: label,
      icon: icon,
      themeColor: themeColor,
      child: ShTextField(
        controller: controller,
        label: label,
        hint: hint,
        labelStyle: labelStyle,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        maxChars: maxChars,
        onValueChanged: onValueChanged,
        validator: validator,
        padding: padding,
      ),
    );
  }
}
