import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
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
              style: context.textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.onSurface,
                fontSize: 14,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              horasTrab,
              style: context.textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.onSurface,
                fontSize: 14,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          if (!hideTotal)
            Expanded(
              flex: 6,
              child: Text(
                "${Localiza.find('total')} - ${valor}",
                textAlign: TextAlign.end,
                style: context.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: context.colors.onSurface,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
