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
  final VoidCallback onTap;
  final Diferenciais? diferencial;

  const OvertimeListTile({
    required this.horaType,
    required this.horaStatus,
    required this.date,
    required this.bancoHoras,
    required this.workedHours,
    required this.amount,
    required this.salary,
    required this.onTap,
    required this.from,
    required this.to,
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
        return AppColors.porcFeriadosColor;
      case HorasType.normal:        
        return AppColors.porcNormalColor;
      case HorasType.banco:
        return Color(horaStatus.color);
      case HorasType.diferencial:
        return diferencial?.color ?? AppColors.porcDiferenciadaColor;
      default:
        return AppColors.disabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);

    return ShDetailedListTile(
      title: formatDateByLocale(date, locale),
      badgeLabel: getBadgeLabel(),
      badgeColor: _getBadgeColor(),
      contentList: [
        IconLabelValue(
          icon: Icons.timeline,
          iconColor: AppColors.primary,
          label: Localiza.find('horasTrabalhadas'),
          value: workedHours,
          labelColor: AppColors.primary,
        ),
        if (!bancoHoras)
          IconLabelValue(
            icon: Icons.payments_outlined,
            iconColor: Color(horaType.colorHex),
            label: Localiza.find('valorReceber'),
            value: amount,
            labelColor: AppColors.primary,
          ),
        IconLabelValue(
          icon: Icons.timelapse,
          iconColor: AppColors.porcFeriadosColor,
          label: "Horário",
          value: "Das ${from}, Até: ${to}",
          labelColor: AppColors.primary,
        ),
      ],
      onTap: onTap,
    );
  }
}
