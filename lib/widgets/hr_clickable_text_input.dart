import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets.dart';

class HrClickableTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final VoidCallback onTap;
  final TextStyle? labelStyle;
  final String? Function(String?)? validator;

  const HrClickableTextInput({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.onTap,
    this.labelStyle,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: HrTextInput(
          controller: controller,
          label: label,
          hint: hint,
          validator: validator,
          labelStyle: labelStyle,
        ),
      ),
    );
  }
}
