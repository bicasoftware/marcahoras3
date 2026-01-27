import 'package:collection/collection.dart';

import '../domain_layer/models.dart';
import '../utils.dart';

class CalendarioPageGenerator {
  static CalendarPageModel generate({
    required List<Horas> horas,
    required int month,
    required int year,
    required DateTime admissao,
    required bool bancoHoras,
    required List<Feriados> feriados,
  }) {
    /// Get the first date
    /// so by using the first week day
    /// we fill the calendar page with empty [CalendarItemModel]
    /// till the first valid date is the same as the weekday position
    final initDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 0);

    final today = DateTime.now();

    /// Fills the calendar with previous months days, but disabled
    final beginEmptyItems = initDate.weekday == DateTime.sunday
        ? []
        : List<CalendarItemEmpty>.filled(
            initDate.weekday,
            CalendarItemEmpty(),
          );

    final listDays = List<CalendarItemModel>.generate(endDate.day, (i) {
      final currentDate = DateTime(year, month, i + 1);
      final feriado = feriados.firstWhereOrNull(
        (f) => f.date.isSameDay(currentDate),
      );

      /// If the current date is before the day the user started working,
      /// the calendar item is disabled
      if (currentDate.isBefore(admissao)) {
        return CalendarItemDisabled(currentDate, today.isSameDay(currentDate));
      }

      final hora = horas.firstWhereOrNull(
        (h) => h.data.isSameDay(currentDate),
      );

      if (hora != null) {
        return bancoHoras
            ? CalendarItemBancoHoras(
                date: currentDate,
                horas: hora,
                isToday: today.isSameDay(currentDate),
                feriado: feriado,
              )
            : CalendarItemComplete(
                date: currentDate,
                horas: hora,
                isToday: today.isSameDay(currentDate),
                feriado: feriado,
              );
      }
      
      return CalendarItemDateOnly(
        currentDate,
        today.isSameDay(currentDate),
        feriado,
      );
    });

    final endEmptyDays = List<CalendarItemEmpty>.generate(
      endDate.weekday == DateTime.sunday ? 0 : (6 - endDate.weekday),
      (_) => CalendarItemEmpty(),
    );

    return CalendarPageModel(
      month: month,
      year: year,
      horas: horas,
      items: [...beginEmptyItems, ...listDays, ...endEmptyDays],
    );
  }
}
