import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets/icon_label_value.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../resources/localizations/strings.dart';
import '../../../utils/utils.dart';
import '../../../widgets.dart';

class OvertimeListTile extends StatelessWidget {
  final HorasType horaType;
  final DateTime date;
  final String workedHours;
  final String amount;
  final String salary;
  final VoidCallback onTap;

  const OvertimeListTile({
    required this.horaType,
    required this.date,
    required this.workedHours,
    required this.amount,
    required this.salary,
    required this.onTap,
    super.key,
  });

  Color _tipoHoraColor() {
    return Color(horaType.colorHex);
  }

  String _tipoHoraLabel(StringsContract strings) {
    return horaType == HorasType.normal
        ? strings.horaNormal
        : strings.horaFeriado;
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final locale = Localizations.localeOf(context);

    return GestureDetector(
      onTap: onTap,
      child: OutlinedCard(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                  backgroundColor: _tipoHoraColor(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  label: Text(
                    _tipoHoraLabel(strings),
                  ),
                ),
              ],
            ),
            const Divider(),
            IconLabelValue(
              icon: Icons.timeline,
              iconColor: AppColors.primary,
              label: strings.horasTrabalhadas,
              value: workedHours,
              labelColor: AppColors.primary,
            ),
            IconLabelValue(
              icon: Icons.payments_outlined,
              iconColor: _tipoHoraColor(),
              label: strings.valorReceber,
              value: amount,
              labelColor: AppColors.primary,
            ),
            IconLabelValue(
              icon: Icons.payment,
              iconColor: AppColors.secondary,
              label: strings.salario,
              value: salary,
              labelColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
