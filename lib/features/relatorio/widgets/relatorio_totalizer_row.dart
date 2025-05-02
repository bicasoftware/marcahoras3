import 'package:flutter/material.dart';

import '../../../resources.dart';
import '../../../utils.dart';

class RelatorioTotalizerRow extends StatelessWidget {
  final String horasTrab;
  final String valor;
  final String label;
  final Color color;
  final bool hideTotal;

  const RelatorioTotalizerRow({
    required this.label,
    required this.color,
    required this.horasTrab,
    required this.valor,
    required this.hideTotal,
  });

  TextStyle _baseStyle(TextTheme theme) {
    return theme.labelLarge!.copyWith(
      fontWeight: FontWeight.bold,
      color: AppColors.onPrimary,
      fontSize: 14,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 8,
        children: [
          Icon(Icons.circle, color: color, size: 16),
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: _baseStyle(theme),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              horasTrab,
              style: _baseStyle(theme),
              textAlign: TextAlign.start,
            ),
          ),
          if (!hideTotal)
            Expanded(
              flex: 6,
              child: Text(
                "${Localiza.find('total')} - ${valor}",
                textAlign: TextAlign.end,
                style: theme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.onPrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
