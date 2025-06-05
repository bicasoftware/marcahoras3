import 'package:flutter/widgets.dart';

import '../../../domain_layer/models/horas.dart';
import '../../../resources/colors.dart';
import '../../../utils.dart';

@immutable
class ReportValues {
  final int workedMinutes;
  final double amount;
  final HorasType horasType;
  final int weekday;
  final Color color;

  ReportValues({
    required this.workedMinutes,
    required this.amount,
    required this.horasType,
    this.weekday = -1,
    this.color = AppColors.porcNormalColor,
  });

  factory ReportValues.empty() {
    return ReportValues(
      workedMinutes: 0,
      amount: 0,
      horasType: HorasType.unknown,
    );
  }

  ReportValues sum({required double amount, required int minutes}) {
    return ReportValues(
      workedMinutes: workedMinutes + minutes,
      amount: this.amount + amount,
      horasType: horasType,
      color: color,
      weekday: weekday,
    );
  }

  String getWorkedHours() {
    return TimeOfDayHelper.formatTimeFromMinutes(
      workedMinutes,
    );
  }

  String getAmount() {
    return CurrencyHelper.formatAmount(amount);
  }
}
