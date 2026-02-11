import 'package:flutter/material.dart';

import '../../../utils.dart';
import 'calendar_header.dart';
import 'widgets/calendar_date_navigator.dart';

class CalendarioScreenHeader extends StatefulWidget {
  final int month;
  final int year;
  final List<int> yearList;
  final VoidCallback onMonthAdd, onMonthDec;
  final void Function(int year) onYearChanged, onMonthChanged;

  const CalendarioScreenHeader({
    required this.month,
    required this.year,
    required this.yearList,
    required this.onMonthAdd,
    required this.onMonthDec,
    required this.onYearChanged,
    required this.onMonthChanged,
    super.key,
  });

  @override
  State<CalendarioScreenHeader> createState() => _CalendarioScreenHeaderState();
}

class _CalendarioScreenHeaderState extends State<CalendarioScreenHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CalendarDateNavigator(
            year: widget.year,
            month: widget.month,
            yearList: widget.yearList,
            onYearChanged: widget.onYearChanged,
            onMonthChanged: widget.onMonthChanged,
            onMonthAdd: widget.onMonthAdd,
            onMonthDec: widget.onMonthDec,
          ),
          const CalendarHeader(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
