import 'package:flutter/material.dart';
import 'package:marcahoras3/domain_layer/models/horas.dart';

import '../../../resources.dart';

class CalendarItem extends StatelessWidget {
  final int weekDay, monthDay;
  final HorasType type;
  final bool isToday;

  const CalendarItem({
    this.weekDay = -1,
    this.monthDay = -1,
    this.type = HorasType.unknown,
    this.isToday = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return AspectRatio(
      aspectRatio: 1.1,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color:  isToday ? AppColors.primaryContainer : AppColors.surface,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: monthDay == -1 && weekDay == -1
            ? Container()
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$monthDay',
                    style: theme.bodyLarge?.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: type != HorasType.unknown
                        ? BoxDecoration(
                            color: Color(type.colorHex),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          )
                        : null,
                  )
                ],
              ),
      ),
    );
  }
}
