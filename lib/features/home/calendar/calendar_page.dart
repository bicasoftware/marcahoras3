import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import 'calendar_item.dart';

class CalendarPage extends StatelessWidget {
  final Empregos? emprego;

  const CalendarPage({
    this.emprego,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.1,
              children: emprego?.calendarPages.first.items.map((it) {
                    switch (it) {
                      case CalendarItemEmpty():
                        return CalendarItem();
                      case CalendarItemDateOnly():
                        return CalendarItem(monthDay: it.date!.day);
                      case CalendarItemComplete():
                        return CalendarItem(
                          type: it.horaType,
                          monthDay: it.date!.day,
                          weekDay: it.weekDay,
                        );
                    }
                  }).toList() ??
                  [],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
