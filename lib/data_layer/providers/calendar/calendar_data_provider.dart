import 'package:collection/collection.dart';

import '../../../domain_layer/models.dart';
import '../../../utils/utils.dart';

class CalendarioPageDataProvider {
  static CalendarPageModel mapToCalendar({
    required List<Horas> horas,
    required int month,
    required int year,
  }) {
    /// Get the first date
    /// so by using the first week day
    /// we fill the calendar page with empty [CalendarItemModel]
    /// till the first valid date is the same as the weekday position
    final initDate = DateTime(year, month);

    final today = DateTime.now();

    final beginEmptyItems = initDate.weekday == 7
        ? []
        : List<CalendarItemModel>.generate(
            initDate.weekday,
            (_) => CalendarItemEmpty(),
            growable: false,
          );

    final calendarDays = <CalendarItemModel>[];

    var currentDate = DateTime(year, month);
    while (currentDate.month == initDate.month) {
      final hora = horas.firstWhereOrNull((h) => h.data.isSameDay(currentDate));
      calendarDays.add(
        hora == null
            ? CalendarItemDateOnly(currentDate, today.isSameDay(currentDate))
            : CalendarItemComplete(
                date: currentDate,
                horas: hora,
                isToday: today.isSameDay(currentDate),
              ),
      );

      currentDate = currentDate.add(Duration(days: 1));
    }

    /// Fills the rest of the calendar items with empty items
    final endEmptyDays = List<CalendarItemModel>.generate(
      (7 - currentDate.weekday),
      (_) => CalendarItemEmpty(),
    );

    return CalendarPageModel(
      month: month,
      year: year,
      horas: horas,
      items: [...beginEmptyItems, ...calendarDays, ...endEmptyDays],
    );
  }
}
