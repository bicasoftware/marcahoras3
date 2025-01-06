import 'package:flutter/material.dart';
import 'package:marcahoras3/resources.dart';

import '../../../presentation_layer/validators/validators.dart';
import '../../../widgets.dart';

class PresentationEmpregoDescricao extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onTextChanged;

  const PresentationEmpregoDescricao({
    required this.controller,
    required this.onTextChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final theme = Theme.of(context).textTheme;

    return ShTextField(      
      controller: controller,
      label: strings.descricaoEmprego,
      hint: strings.descricaoEmprego,
      labelStyle: theme.labelLarge,
      // icon: Icon(Icons.text_fields),
      onValueChanged: onTextChanged,
      isOutlined: false,      
      validator: (s) {
        return MinCharactersValidator.validate(
          controller.text,
          6,
          strings,
        );
      },
    );
  }
}
