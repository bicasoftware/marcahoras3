import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../utils/date_utils.dart';
import 'calendar_item.dart';

class CalendarPage extends StatelessWidget {
  final CalendarPageModel page;
  final List<Diferenciais> diferenciais;
  final void Function(Horas? hora, DateTime? data, Feriados? feriado)? onCalendarItemTap;

  const CalendarPage({
    required this.page,
    required this.onCalendarItemTap,
    required this.diferenciais,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Padding(
      padding: const .symmetric(horizontal: 8.0),
      child: GridView.count(
        crossAxisCount: 7,
        shrinkWrap: true,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 1.1,
        padding: EdgeInsets.zero,
        children: page.items.map((it) {
          switch (it) {
            case CalendarItemEmpty():
              return CalendarItem(
                enabled: false,
              );
            case CalendarItemDisabled():
              return CalendarItem(
                monthDay: it.date!.day,
                isToday: it.isToday ?? false,
                data: it.date,
                enabled: false,
              );
            case CalendarItemDateOnly():
              return CalendarItem(
                monthDay: it.date!.day,
                isToday: it.isToday ?? false,
                data: it.date,
                onCalendarItemTap: onCalendarItemTap,
                feriado: it.feriado,
              );
            case CalendarItemComplete():
              return CalendarItem(
                type: it.horaType,
                monthDay: it.date?.day ?? -1,
                weekDay: it.weekDay,
                isToday: it.isToday ?? false,
                data: it.date,
                hora: it.horas,
                onCalendarItemTap: onCalendarItemTap,
                feriado: it.feriado,
                diferencial: diferenciais.firstWhereOrNull(
                  (d) => isSameWeekday(d.weekday, it.date ?? now),
                ),
              );
            case CalendarItemBancoHoras():
              return CalendarItem(
                bancoHoras: true,
                monthDay: it.date?.day ?? -1,
                weekDay: it.weekDay,
                isToday: it.isToday ?? false,
                data: it.date,
                hora: it.horas,
                onCalendarItemTap: onCalendarItemTap,
                type: HorasType.banco,
                feriado: it.feriado,
              );
          }
        }).toList(),
      ),
    );
  }
}
