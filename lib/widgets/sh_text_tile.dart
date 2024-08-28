import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marcahoras3/resources.dart';

import '../presentation_layer/validators/validators.dart';
import '../widgets.dart';

class ShTextTile extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final TextStyle? labelStyle;
  final Icon? icon;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int? maxChars;

  const ShTextTile({
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.labelStyle,
    this.icon,
    this.keyboardType,
    this.inputFormatters,
    this.maxChars,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return IndicatorTile(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            if (icon != null) Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: icon!,
            ),            
            Expanded(
              child: ShTextField(
                controller: controller,
                label: label,
                hint: hint,
                labelStyle: labelStyle,
                isOutlined: false,
                inputFormatters: inputFormatters,
                keyboardType: keyboardType,
                maxChars: maxChars,
                validator: (s) {
                  return MinCharactersValidator.validate(
                    controller.text,
                    6,
                    strings,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
