import '../../../data_layer/providers.dart';
import '../../models.dart';

class CalendarPageGeneratorUseCase {
  Future<CalendarPageModel> call({
    required List<Horas> horas,
    required int month,
    required int year,
    required DateTime admissao,
  }) async {
    return await CalendarioPageGenerator.generate(
      horas: horas,
      month: month,
      year: year,
      admissao: admissao,
    );
  }
}
