import '../../domain_layer/models.dart';
import '../../utils/utils.dart';
import '../dtos.dart';

extension HorasMapper on HorasDto {
  Horas toHoras() {
    return Horas(
      id: id!,
      empregoId: empregoId!,
      data: data!,
      inicio: TimeOfDayHelper.parseString(inicio!),
      termino: TimeOfDayHelper.parseString(termino!),
      tipoHora: HorasType.fromLetter(tipoHora),
      bancoHoras: bancoHoras ?? false,
    );
  }
}

extension HorasDtoMapper on Horas {
  HorasDto toHorasDto() {
    return HorasDto(
      bancoHoras: bancoHoras,
      data: data,
      empregoId: empregoId,
      inicio: TimeOfDayHelper.formatTime(inicio, true),
      termino: TimeOfDayHelper.formatTime(termino, true),
      tipoHora: tipoHora.letter,
      id: id,
    );
  }
}
