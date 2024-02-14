import 'package:flutter/material.dart';
import 'package:marcahoras3/domain_layer/models/horas.dart';

class CalendarItem extends StatelessWidget {
  final int weekDay, monthDay;
  final HorasType type;

  const CalendarItem({
    super.key,
    required this.weekDay,
    required this.monthDay,
    this.type = HorasType.normal,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AspectRatio(
      aspectRatio: 1.1,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$monthDay'),
            Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Color(type.colorHex),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
