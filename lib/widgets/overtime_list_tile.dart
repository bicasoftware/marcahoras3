import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../widgets.dart';
import '../resources.dart';
import '../utils.dart';

class OvertimeListTile extends StatelessWidget {
  final HorasType horaType;
  final HoraStatus horaStatus;
  final bool bancoHoras;
  final DateTime date;
  final String workedHours;
  final String amount;
  final String salary;
  final String from, to;
  final VoidCallback? onTap;
  final Diferenciais? diferencial;
  final List<ShPopupMenuItemData> popupOptions;

  const OvertimeListTile({
    required this.horaType,
    required this.horaStatus,
    required this.date,
    required this.bancoHoras,
    required this.workedHours,
    required this.amount,
    required this.salary,
    required this.from,
    required this.to,
    required this.popupOptions,
    this.onTap,
    this.diferencial,
    super.key,
  });

  String getBadgeLabel() {
    if (bancoHoras) {
      return horaStatus == HoraStatus.burned
          ? Localiza.find('compensada')
          : Localiza.find('bancoHorasAbrev');
    }

    switch (horaType) {
      case HorasType.feriado:
        return Localiza.find('horaFeriado');
      case HorasType.diferencial:
        return Localiza.find('diferencial');
      default:
        return Localiza.find('horaNormal');
    }
  }

  Color _getBadgeColor() {
    switch (horaType) {
      case HorasType.feriado:
        return ExtraColors.porcFeriadosColor;
      case HorasType.normal:
        return ExtraColors.porcNormalColor;
      case HorasType.banco:
        return Color(horaStatus.color);
      case HorasType.diferencial:
        return diferencial?.color ?? ExtraColors.porcDiferenciadaColor;
      default:
        return ExtraColors.disabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShOvertimeCard(
      date: formatDateByLocale(date, context.locale),
      timeRange: Localiza.find(
        'dasAte',
      ).replaceAll('{INI}', from).replaceAll('{END}', to),
      badgeText: getBadgeLabel(),
      horasFeitasLabel: 'horasTrabalhadas',
      horasFeitas: workedHours,
      valorReceberText: 'valorReceber',
      valorReceber: amount,
      badgeColor: _getBadgeColor(),
      popupOptions: popupOptions,
      onTap: onTap,
    );
  }
}
