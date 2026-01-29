import 'package:drift/drift.dart';

import '../../domain_layer/models/hora_fixo.dart';
import '../../utils.dart';
import '../database/db_connector_drift.dart';
import '../dtos.dart';

extension HoraFixoDtoMapper on HoraFixoDto {
  HoraFixo toModel() {
    return HoraFixo(
      id: id,
      idEmprego: idEmprego!,
      valorNormal: valorNormal?.toDouble() ?? 0.0,
      valorFeriado: valorFeriado?.toDouble() ?? 0.0,
      vigencia: parseVigencia(vigencia!),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emprego_id': idEmprego,
      'valor_normal': valorNormal,
      'valor_feriados': valorFeriado,
      'vigencia': vigencia,
    };
  }

  static HoraFixoDto fromJson(Map<String, dynamic> json) {
    return HoraFixoDto(
      id: json['id'],
      idEmprego: json['emprego_id'],
      valorNormal: (json['valor_normal'] ?? 0.0) as num,
      valorFeriado: (json['valor_feriados'] ?? 0.0) as num,
      vigencia: json['vigencia'],
    );
  }

  static List<HoraFixoDto> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => fromJson(json as Map<String, dynamic>))
        .toList();
  }

  DbHoraFixoCompanion toCompanion({String? newId}) {
    return DbHoraFixoCompanion(
      id: Value(newId!),
      idEmprego: Value(idEmprego!),
      valorNormal: Value(valorNormal?.toDouble() ?? 0.0),
      valorFeriado: Value(valorFeriado?.toDouble() ?? 0.0),
      vigencia: Value(vigencia!),
    );
  }
}

extension HoraFixoModelMapper on HoraFixo {
  HoraFixoDto toDto([String? newId]) {
    return HoraFixoDto(
      id: newId ?? id,
      idEmprego: idEmprego,
      valorNormal: valorNormal,
      valorFeriado: valorFeriado,
      vigencia: formatVigenciaDate(vigencia),
    );
  }
}
