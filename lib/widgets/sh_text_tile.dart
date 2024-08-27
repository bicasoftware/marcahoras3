import 'package:flutter/material.dart';
import 'package:marcahoras3/resources.dart';

import '../presentation_layer/validators/validators.dart';
import '../widgets.dart';

class ShTextTile extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final TextStyle? labelStyle;

  const ShTextTile({
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.labelStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return IndicatorTile(
      child: Container(
        padding: EdgeInsets.only(left: 16),
        child: ShTextField(
          controller: controller,
          label: label,
          hint: hint,
          labelStyle: labelStyle,
          validator: (s) {
            return MinCharactersValidator.validate(
              controller.text,
              6,
              strings,
            );
          },
        ),
      ),
    );
  }
}
