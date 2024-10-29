import 'package:flutter/material.dart';

import '../../../resources.dart';
import '../../../widgets.dart';

class RelatorioTotalizerRow extends StatelessWidget {
  final String leftLabel, endLabel;
  final Icon icon;
  final EdgeInsets padding;

  const RelatorioTotalizerRow({
    required this.leftLabel,
    required this.endLabel,
    required this.icon,
    this.padding = const EdgeInsets.only(bottom: 8.0),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: IconLabel(
              label: leftLabel,
              icon: icon,
              labelColor: AppColors.onPrimary,              
            ),
          ),         
          Expanded(
            flex: 5,
            child: Text(
              endLabel,
              textAlign: TextAlign.end,
              style: theme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
