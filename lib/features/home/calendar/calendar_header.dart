import 'package:flutter/material.dart';

import '../../../resources.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
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
    final theme = Theme.of(context).textTheme;

    return Expanded(
      child: Text(weekday.toUpperCase(),
          textAlign: TextAlign.center,
          style: theme.labelLarge?.copyWith(color: AppColors.onPrimary)),
    );
  }
}
