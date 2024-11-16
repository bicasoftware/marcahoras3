import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../resources/localizations/strings.dart';
import '../../../utils/utils.dart';
import '../../../widgets.dart';

class RelatorioHorasListTile extends StatelessWidget {
  final ReportHora hora;

  const RelatorioHorasListTile({
    required this.hora,
    super.key,
  });

  Color _tipoHoraColor() {
    return Color(hora.type.colorHex);
  }

  String _tipoHoraLabel(StringsContract strings) {
    return hora.type == HorasType.normal
        ? strings.horaNormal
        : strings.horaFeriado;
  }
  

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final locale = Localizations.localeOf(context);

    return OutlinedCard(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: _IconLabel(
                  icon: Icons.date_range,
                  iconColor: AppColors.onSurface,
                  label:
                      "${strings.data}: ${formatDateByLocale(hora.date, locale)}",
                ),
              ),
              Badge(
                backgroundColor: _tipoHoraColor(),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                label: Text(
                  _tipoHoraLabel(strings),
                ),
              ),
            ],
          ),
          const Divider(),
          _IconLabel(
            icon: Icons.timeline,
            iconColor: AppColors.primary,
            label: "${strings.horasTrabalhadas}: ${hora.workedHours}",
          ),
          _IconLabel(
            icon: Icons.payments_outlined,
            iconColor: _tipoHoraColor(),
            label:
                "${strings.valorReceber}: ${hora.amount}",
          ),
          _IconLabel(
            icon: Icons.payment,
            iconColor: AppColors.secondary,
            label:
                "${strings.salario}: ${hora.salary}",
          ),
        ],
      ),
    );
  }
}

class _IconLabel extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? iconColor;

  const _IconLabel({
    required this.label,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8),
            child: Icon(
              icon,
              size: 16,
              color: iconColor,
            ),
          ),
          Text(
            label,
            style: theme.labelLarge?.copyWith(
              fontWeight: FontWeight.normal,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
