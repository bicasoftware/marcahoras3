import 'dart:isolate';

import '../../../data_layer/providers.dart';
import '../../models.dart';

class CalendarPageGeneratorUseCase {
  Future<CalendarPageModel> call(List<Horas> horas, int month, int year) async {
    return await Isolate.run<CalendarPageModel>(
      () {
        return CalendarioPageDataProvider.mapToCalendar(
          horas: horas,
          month: month,
          year: year,
        );
      },
    );
  }
}
