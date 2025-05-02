import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../widgets.dart';
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
    super.key,
  });

  String getBadgeLabel() {
    if (bancoHoras) {
      return horaStatus == HoraStatus.burned
          ? Localiza.find('compensada')
          : Localiza.find('bancoHorasAbrev');
    }

    return horaType == HorasType.feriado
        ? Localiza.find('horaFeriado')
        : Localiza.find('horaNormal');
  }

  Color _getBadgeColor() {
    return bancoHoras ? Color(horaStatus.color) : Color(horaType.colorHex);
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);

    return GestureDetector(
      onTap: onTap,
      child: OutlinedCard(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        margin: EdgeInsets.only(top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: IconLabel(
                    icon: Icon(Icons.date_range, color: AppColors.secondary),
                    label: formatDateByLocale(date, locale),
                    labelColor: AppColors.onSurface,
                  ),
                ),
                Badge(
                  backgroundColor: _getBadgeColor(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  label: Text(getBadgeLabel()),
                ),
              ],
            ),
            const Divider(),
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
        ),
      ),
    );
  }
}
