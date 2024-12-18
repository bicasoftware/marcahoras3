import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../presentation_layer/validators/validators.dart';
import '../../../resources.dart';
import '../../../utils/currency_helper.dart';
import '../../../widgets.dart';

class PresentationEmpregoSalario extends StatelessWidget {
  final MoneyMaskedTextController controller;
  final ValueChanged<String> onSalarioChanged;

  const PresentationEmpregoSalario({
    required this.controller,
    required this.onSalarioChanged,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final theme = Theme.of(context).textTheme;

    return ShTextTile(
      controller: controller,
      label: strings.salario,
      hint: CurrencyHelper.formatAmount(1000),
      labelStyle: theme.labelLarge,
      icon: Icon(Icons.monetization_on),
      onValueChanged: onSalarioChanged,
      validator: (s) {
        if (controller.numberValue <= 0.0) {
          return "Salário deve ser preenchido corretamente";
        }
        return MinCharactersValidator.validate(s, 6, strings);
      },
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: TextInputType.number,
    );
  }
}
