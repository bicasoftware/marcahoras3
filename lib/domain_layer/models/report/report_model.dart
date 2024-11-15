import 'package:marcahoras3/domain_layer/models/report/report_hora.dart';

class ReportModel {
  final int year, month;
  final List<ReportHora> hours;
  final String totalNormal, totalDiff, totalTotal;
  final String amountNormal, amountDiff, totalAmount;

  ReportModel({
    required this.year,
    required this.month,
    required this.hours,
    required this.totalNormal,
    required this.totalDiff,
    required this.totalTotal,
    required this.amountNormal,
    required this.amountDiff,
    required this.totalAmount,
  });

  ReportModel copyWith({
    int? year,
    int? month,
    List<ReportHora>? hours,
    String? totalNormal,
    String? totalDiff,
    String? totalTotal,
    String? amountNormal,
    String? amountDiff,
    String? totalAmount,
  }) {
    return ReportModel(
      year: year ?? this.year,
      month: month ?? this.month,
      hours: hours ?? this.hours,
      totalTotal: totalTotal ?? this.totalTotal,
      totalNormal: totalNormal ?? this.totalNormal,
      totalDiff: totalDiff ?? this.totalDiff,
      amountNormal: amountNormal ?? this.amountNormal,
      amountDiff: amountDiff ?? this.amountDiff,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
