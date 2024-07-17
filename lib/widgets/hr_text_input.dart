import 'package:flutter/material.dart';
import 'package:marcahoras3/presentation_layer/validators/form_validator.dart';

class HrTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final EdgeInsets padding;
  final List<String?>? validators;

  const HrTextInput({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.validators,
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
            style: theme.labelLarge,
          ),
          TextFormField(
            controller: controller,
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
            validator: (v) {
              return FormValidator.validateAll(validators!);
            },
          ),
        ],
      ),
    );
  }
}
