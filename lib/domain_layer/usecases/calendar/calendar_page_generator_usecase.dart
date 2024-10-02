import '../../../data_layer/providers.dart';
import '../../models.dart';

class CalendarPageGeneratorUseCase {
  CalendarPageModel call(List<Horas> horas, int month, int year) {
    return CalendarioPageDataProvider.mapToCalendar(
      horas: horas,
      month: month,
      year: year,
    );
  }
}
