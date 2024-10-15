import 'package:flutter/material.dart';
import 'package:marcahoras3/domain_layer/models/horas.dart';

import '../../../resources.dart';

class CalendarItem extends StatelessWidget {
  final int weekDay, monthDay;
  final HorasType type;
  final bool isToday;
  final DateTime? data;
  final Horas? hora;
  final void Function(Horas? hora, DateTime? data)? onCalendarItemTap;

  const CalendarItem({
    this.onCalendarItemTap,
    this.weekDay = -1,
    this.monthDay = -1,
    this.type = HorasType.unknown,
    this.isToday = false,
    this.hora,
    this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        if (onCalendarItemTap != null) {
          onCalendarItemTap!(hora, data);
        }
      },
      child: AspectRatio(
        aspectRatio: 1.1,
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(2),
          decoration: monthDay > -1
              ? BoxDecoration(
                  color:
                      isToday ? AppColors.primaryContainer : AppColors.surface,
                  border: Border.all(
                    color: AppColors.shadow.withAlpha(20),
                  ),
                  borderRadius: BorderRadius.circular(8),
                )
              : null,
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
                        // fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
