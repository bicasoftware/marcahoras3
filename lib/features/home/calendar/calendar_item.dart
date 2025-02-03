import 'package:flutter/material.dart';

import '../../../domain_layer/models/horas.dart';
import '../../../resources.dart';

class CalendarItem extends StatelessWidget {
  final int weekDay, monthDay;
  final HorasType type;
  final bool isToday;
  final DateTime? data;
  final Horas? hora;
  final bool enabled;
  final void Function(Horas? hora, DateTime? data)? onCalendarItemTap;

  const CalendarItem({
    this.onCalendarItemTap,
    this.weekDay = -1,
    this.monthDay = -1,
    this.type = HorasType.unknown,
    this.isToday = false,
    this.enabled = true,
    this.hora,
    this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        if (onCalendarItemTap != null) {
          onCalendarItemTap!(hora, data);
        }
      },
      child: Container(
        decoration: monthDay > -1
            ? BoxDecoration(
                color: enabled
                    ? isToday
                        ? AppColors.primaryContainer
                        : AppColors.surface
                    : AppColors.disabled.withAlpha(20),
                border: Border.all(
                  color: AppColors.shadow.withAlpha(20),
                ),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        child: monthDay == -1 && weekDay == -1
            ? Container()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$monthDay',
                    style: theme.bodyLarge?.copyWith(
                      color: enabled ? AppColors.onSurface : AppColors.disabled,
                    ),
                  ),
                  Container(
                    height: 4,
                    width: 10,
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
