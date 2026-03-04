import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marcahoras3/widgets.dart';

import '../../../utils.dart';

class SalariosInputTile extends StatelessWidget {
  final MoneyMaskedTextController controller;
  final ValueChanged<double> onSalarioValueChanged;

  const SalariosInputTile({
    super.key,
    required this.controller,
    required this.onSalarioValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return ShTextTile(
      themeColor: colors.primary,
      controller: controller,
      label: Localiza.find('salario'),
      hint: CurrencyHelper.formatAmount(1000),
      labelStyle: textTheme.labelLarge,
      icon: Icons.monetization_on,
      onValueChanged: (_) => onSalarioValueChanged(controller.numberValue),
      validator: (s) {
        if (controller.numberValue <= 0.0) {
          return Localiza.find('salarioInvalido');
        }

        return null;
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
    );
  }
}
