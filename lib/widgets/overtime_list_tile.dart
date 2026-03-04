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
    return ShDetailedListTile(
      title: formatDateByLocale(date, context.locale),
      padding: .all(16),
      popupOptions: popupOptions,
      badgeLabel: getBadgeLabel(),
      badgeColor: _getBadgeColor(),
      contentList: [
        IconLabelValue(
          icon: Icons.timeline,
          iconColor: context.colors.secondary,
          label: Localiza.find('horasTrabalhadas'),
          value: workedHours,
          labelColor: context.colors.onSurface,
        ),
        if (!bancoHoras)
          IconLabelValue(
            icon: Icons.payments_outlined,
            iconColor: Color(horaType.colorHex),
            label: Localiza.find('valorReceber'),
            value: amount,
            labelColor: context.colors.onSurface,
          ),
        IconLabelValue(
          icon: Icons.timelapse,
          iconColor: ExtraColors.porcFeriadosColor,
          label: Localiza.find('turno'),
          value: Localiza.find(
            'dasAte',
          ).replaceAll('{INI}', from).replaceAll('{END}', to),
          labelColor: context.colors.onSurface,
        ),
      ],
      onTap: onTap,
    );
  }
}
