import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../utils.dart';

class RelatorioTotalizerRow extends StatelessWidget {
  final HorasType tipoHora;
  final String horasTrab;
  final String valor;

  const RelatorioTotalizerRow({
    required this.tipoHora,
    required this.horasTrab,
    required this.valor,
  });

  String getLabel() {
    switch (tipoHora) {
      case HorasType.normal:
        return Localiza.find('normais');
      case HorasType.feriado:
        return Localiza.find('feriados');
      default:
        return Localiza.find('totais');
    }
  }

  Color getIconColor() {
    switch (tipoHora) {
      case HorasType.normal:
        return AppColors.porcNormalColor;
      case HorasType.feriado:
        return AppColors.porcFeriadosColor;
      default:
        return AppColors.onPrimary;
    }
  }

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
          Icon(Icons.circle, color: getIconColor(), size: 16),
          Expanded(
            flex: 3,
            child: Text(
              getLabel(),
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
