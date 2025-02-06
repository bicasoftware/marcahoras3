import 'package:drift/drift.dart';
import 'package:realm/realm.dart';

import '../../domain_layer/models.dart';
import '../../utils/utils.dart';
import '../database/db_connector_drift.dart';
import '../dtos.dart';
import '../tables/realm_models.dart';

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

  HorasRealm toRealm() {
    return HorasRealm(
      Uuid.v4().toString(),
      data: data,
      inicio: inicio,
      termino: termino,
      tipoHora: tipoHora,
      bancoHoras: bancoHoras,
      empregoId: empregoId,
    );
  }

  DbHorasCompanion toCompanion({String? newId}) {
    return DbHorasCompanion(
      id: Value(newId ?? id!),
      data: Value(data),
      inicio: Value(inicio!),
      termino: Value(termino!),
      tipoHora: Value(tipoHora!),
      bancoHoras: Value(bancoHoras ?? false),
      empregoId: Value(empregoId!),
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

extension HorasRealmHelper on HorasRealm {
  HorasDto toDto() {
    return HorasDto(
      bancoHoras: bancoHoras,
      data: data,
      inicio: inicio,
      termino: termino,
      tipoHora: tipoHora,
      id: id,
      empregoId: empregoId,
    );
  }

  void updateFromDto(HorasDto dto) {
    this.bancoHoras = dto.bancoHoras ?? this.bancoHoras;
    this.data = dto.data ?? this.data;
    this.inicio = dto.inicio ?? this.inicio;
    this.termino = dto.termino ?? this.termino;
    this.tipoHora = dto.tipoHora ?? this.tipoHora;
    this.id = dto.id ?? this.id;
  }
}
