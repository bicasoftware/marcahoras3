import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import 'calendar_item.dart';

class CalendarPage extends StatelessWidget {
  final CalendarPageModel page;

  const CalendarPage({
    required this.page,
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
              children: page.items.map(
                (it) {
                  switch (it) {
                    case CalendarItemEmpty():
                      return CalendarItem();
                    case CalendarItemDateOnly():
                      return CalendarItem(
                          monthDay: it.date!.day, isToday: it.isToday ?? false);
                    case CalendarItemComplete():
                      return CalendarItem(
                        type: it.horaType,
                        monthDay: it.date?.day ?? -1,
                        weekDay: it.weekDay,
                        isToday: it.isToday ?? false,
                      );
                  }
                },
              ).toList(),
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
