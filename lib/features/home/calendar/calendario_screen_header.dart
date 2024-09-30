import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import 'calendar_header.dart';
import 'widgets/calendar_date_navigator.dart';

class CalendarioScreenHeader extends StatefulWidget {
  final List<Empregos> empregos;
  final int? empregoPos;
  final int month;
  final int year;
  final VoidCallback onMonthAdd, onMonthDec;
  final void Function(int year) onYearChanged, onMonthChanged;

  const CalendarioScreenHeader({
    required this.empregos,
    required this.month,
    required this.year,
    required this.onMonthAdd,
    required this.onMonthDec,
    required this.onYearChanged,
    required this.onMonthChanged,
    this.empregoPos,
    super.key,
  });

  @override
  State<CalendarioScreenHeader> createState() => _CalendarioScreenHeaderState();
}

class _CalendarioScreenHeaderState extends State<CalendarioScreenHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.inversePrimary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CalendarDateNavigator(
            year: widget.year,
            month: widget.month,
            onYearChanged: widget.onYearChanged,
            onMonthChanged: widget.onMonthChanged,
            onMonthAdd: widget.onMonthAdd,
            onMonthDec: widget.onMonthDec,
          ),
          const CalendarHeader(),
        ],
      ),
    );
  }
}
