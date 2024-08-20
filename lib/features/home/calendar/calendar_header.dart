import 'package:flutter/material.dart';

import '../../../resources.dart';
import '../../../widgets.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: context
            .strings()
            .weekDays
            .map((e) => _WeekDayItem(weekday: e))
            .toList(),
      ),
    );
  }
}

class _WeekDayItem extends StatelessWidget {
  final String weekday;

  const _WeekDayItem({
    required this.weekday,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        weekday.toUpperCase(),
        textAlign: TextAlign.center,
      ),
    );
  }
}
