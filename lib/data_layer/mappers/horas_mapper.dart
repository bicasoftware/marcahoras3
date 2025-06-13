import 'package:drift/drift.dart';

import '../../domain_layer/models.dart';
import '../../utils.dart';
import '../database/db_connector_drift.dart';
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
      horaStatus: HoraStatus.fromLetter(horaStatus),
      createdAt: createdAt ?? DateTime(1970, 1, 1),
    );
  }

  DbHorasCompanion toCompanion({String? newId, required DateTime createdAt}) {
    return DbHorasCompanion(
      id: Value(newId ?? id!),
      data: Value(data),
      inicio: Value(inicio!),
      termino: Value(termino!),
      tipoHora: Value(tipoHora!),
      statusHora: Value(horaStatus!),
      empregoId: Value(empregoId!),
      createdAt: Value(createdAt),
    );
  }
}

extension HorasDtoMapper on Horas {
  HorasDto toHorasDto([String? newId]) {
    return HorasDto(
      data: data,
      empregoId: empregoId,
      inicio: TimeOfDayHelper.formatTime(inicio, true),
      termino: TimeOfDayHelper.formatTime(termino, true),
      tipoHora: tipoHora.letter,
      horaStatus: horaStatus.letter,
      id: newId ?? id,
    );
  }
}
