import '../../../utils/calendar_page_generator.dart';
import '../../models.dart';

class CalendarPageGeneratorUseCase {
  Future<CalendarPageModel> call({
    required List<Horas> horas,
    required int month,
    required int year,
    required DateTime admissao,
    required bool bancoHoras,
    required List<Feriados> feriados,
  }) async {
    return await CalendarioPageGenerator.generate(
      horas: horas,
      month: month,
      year: year,
      admissao: admissao,
      bancoHoras: bancoHoras,
      feriados: feriados,
    );
  }
}
