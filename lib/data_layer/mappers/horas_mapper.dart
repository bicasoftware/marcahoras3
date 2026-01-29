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
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'emprego_id': empregoId,
      'data': formatDate(data!, true),
      'inicio': inicio,
      'termino': termino,
      'tipo_hora': tipoHora,
      'hora_status': horaStatus,
      'id': ?id,
    };

    return map;
  }

  static HorasDto fromJson(Map<String, dynamic> map) {
    return HorasDto(
      id: map['id'] != null ? map['id'] as String : "",
      empregoId: map['emprego_id'] != null ? map['emprego_id'] as String : "",
      data: map['data'] is int
          ? getDateFromMillis(map['data'])
          : parseDate(map['data']),
      inicio: map['inicio'] != null ? map['inicio'] as String : null,
      termino: map['termino'] != null ? map['termino'] as String : null,
      tipoHora: map['tipo_hora'] != null ? map['tipo_hora'] as String : null,
      horaStatus: map['hora_status'] != null
          ? map['hora_status'] as String
          : null,
      createdAt: map['created_at'] is int
          ? getDateFromMillis(map['created_at'])
          : parseDate(map['created_at']),
    );
  }

  static List<HorasDto> fromJsonList(dynamic list) {
    if (list.isEmpty) return [];
    return list.map<HorasDto>((h) => fromJson(h)).toList();
  }

  DbHorasCompanion toCompanion({String? newId}) {
    return DbHorasCompanion(
      id: Value(newId ?? id!),
      data: Value(data),
      inicio: Value(inicio!),
      termino: Value(termino!),
      tipoHora: Value(tipoHora!),
      statusHora: Value(horaStatus!),
      empregoId: Value(empregoId!),
    );
  }
}



extension HorasDtoMapper on Horas {
  HorasDto toHorasDto([String? newId]) {
    return HorasDto(
      data: data,
      empregoId: empregoId,
      inicio: TimeOfDayHelper.formatTime(inicio),
      termino: TimeOfDayHelper.formatTime(termino),
      tipoHora: tipoHora.letter,
      horaStatus: horaStatus.letter,
      id: newId ?? id,
    );
  }
}
