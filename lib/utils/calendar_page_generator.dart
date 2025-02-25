import 'package:collection/collection.dart';

import '../domain_layer/models.dart';
import '../utils.dart';

class CalendarioPageGenerator {
  static CalendarPageModel generate({
    required List<Horas> horas,
    required int month,
    required int year,
    required DateTime admissao,
  }) {
    /// Get the first date
    /// so by using the first week day
    /// we fill the calendar page with empty [CalendarItemModel]
    /// till the first valid date is the same as the weekday position
    final initDate = DateTime(year, month);

    final today = DateTime.now();

    /// Fills the calendar with previous months days, but disabled
    var beginEmptyItems = <CalendarItemModel>[];
    if (initDate.weekday < 7) {
      var prevMonthDate = DateTime(year, month).subtract(Duration(days: 1));

      for (int i = initDate.weekday; i > 0; i--) {
        beginEmptyItems.add(
          CalendarItemDisabled(prevMonthDate, false),
        );

        prevMonthDate = prevMonthDate.subtract(Duration(days: 1));
      }

      beginEmptyItems = beginEmptyItems.reversed.toList();
    }

    final calendarDays = <CalendarItemModel>[];

    var currentDate = DateTime(year, month);
    while (currentDate.month == initDate.month) {
      /// If the current date is before the day the user started working,
      /// the calendar item is disabled
      if (currentDate.isBefore(admissao)) {
        calendarDays.add(
          CalendarItemDisabled(
            currentDate,
            today.isSameDay(currentDate),
          ),
        );
      } else {
        final hora =
            horas.firstWhereOrNull((h) => h.data.isSameDay(currentDate));
        calendarDays.add(
          /// If there's no overtime stored for this day, add [CalendarItemDateOnly]
          /// otherwise adds a [CalendarItemComplete]
          hora == null
              ? CalendarItemDateOnly(currentDate, today.isSameDay(currentDate))
              : CalendarItemComplete(
                  date: currentDate,
                  horas: hora,
                  isToday: today.isSameDay(currentDate),
                ),
        );
      }

      currentDate = currentDate.add(Duration(days: 1));
    }

    /// Fills the rest of the calendar items next month days, but disabled
    var endEmptyDays = <CalendarItemModel>[];
    while (currentDate.weekday < 7) {
      endEmptyDays.add(CalendarItemDisabled(currentDate, false));

      currentDate = currentDate.add(Duration(days: 1));
    }

    return CalendarPageModel(
      month: month,
      year: year,
      horas: horas,
      items: [...beginEmptyItems, ...calendarDays, ...endEmptyDays],
    );
  }
}
