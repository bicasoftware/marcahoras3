import '../../domain_layer/models.dart';
import '../dtos.dart';

extension HorasMapper on HorasDto {
  Horas toHoras() {
    /// Return a Horas model to be used
    return Horas(
      id: id!,
      empregoId: empregoId!,
      data: data!,
      inicio: inicio!,
      termino: termino!,
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
      inicio: inicio,
      termino: termino,
      tipoHora: tipoHora.letter,
      id: id,
    );
  }
}
