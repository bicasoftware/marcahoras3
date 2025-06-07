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
  final int porc;

  ReportValues({
    required this.workedMinutes,
    required this.amount,
    required this.horasType,
    required this.porc,
    this.weekday = -1,
    this.color = AppColors.porcNormalColor,
  });

  factory ReportValues.empty() {
    return ReportValues(
      workedMinutes: 0,
      amount: 0,
      horasType: HorasType.unknown,
      porc: 0,
    );
  }

  factory ReportValues.withPercentage(int porc) {
    return ReportValues(
      workedMinutes: 0,
      amount: 0,
      horasType: HorasType.unknown,
      porc: porc,
    );
  }

  ReportValues sum({required double amount, required int minutes}) {
    return ReportValues(
      workedMinutes: workedMinutes + minutes,
      amount: this.amount + amount,
      horasType: horasType,
      color: color,
      weekday: weekday,
      porc: porc,      
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
