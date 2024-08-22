import 'package:flutter/material.dart';

class HrTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final EdgeInsets padding;
  final String? Function(String?)? validator;
  final TextStyle? labelStyle;

  const HrTextInput({
    super.key,
    required this.controller,
    required this.hint,
    required this.label,
    this.labelStyle,
    this.validator,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            label,
            style: labelStyle ?? theme.labelLarge,
          ),
          TextFormField(
            controller: controller,
            autofocus: false,
            decoration: InputDecoration(
              filled: true,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              hintText: hint,
              errorStyle: theme.labelMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
