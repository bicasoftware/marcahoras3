import 'package:flutter/material.dart';

import '../../../utils.dart';
import '../../../widgets.dart';

class ShTotalsTile extends StatelessWidget {
  final int minutes;
  final double amount;

  const ShTotalsTile({
    required this.minutes,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    final labelTheme = textTheme.labelLarge?.copyWith(
      color: colors.onPrimaryFixedVariant,
      fontWeight: .normal,
    );

    return Container(
      padding: const .all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: .min,
        children: [
          Row(
            children: [
              ShText(
                'reportTotal',
                style: labelTheme,
              ),
              const Spacer(),
              Text(TimeOfDayHelper.formatTimeFromMinutes(minutes)),
            ],
          ),
          Row(
            children: [
              ShText(
                'reportTotalReceber',
                style: labelTheme,
              ),
              const Spacer(),
              Text(
                CurrencyHelper.formatAmount(amount),
                style: textTheme.bodyLarge?.copyWith(
                  color: colors.secondary,
                  fontWeight: .bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
