import 'package:flutter/material.dart';

import '../../../utils.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      color: colors.onPrimaryFixedVariant,
      padding: .all(8),
      child: Row(
        children: Localiza.findList(
          'weekDays',
        ).map((e) => _WeekDayItem(weekday: e)).toList(),
      ),
    );
  }
}

class _WeekDayItem extends StatelessWidget {
  final String weekday;

  const _WeekDayItem({required this.weekday});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Expanded(
      child: Text(
        weekday.toUpperCase(),
        textAlign: TextAlign.center,
        style: theme.labelLarge?.copyWith(color: colors.onPrimary),
      ),
    );
  }
}
