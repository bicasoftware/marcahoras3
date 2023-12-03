import '../../domain_layer/models.dart';
import '../../utils/utils.dart';
import '../dtos.dart';

extension HorasMapper on HorasDto {
  Horas toHoras() {
    /// Validate fields to be obligatory as not null
    assertAllNotNull(
      [
        id,
        empregoId,
        data,
        inicio,
        termino,
      ],
    );

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
