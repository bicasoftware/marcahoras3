import 'package:drift/drift.dart';

import '../../domain_layer/models.dart';
import '../../utils.dart';
import '../database/db_connector_drift.dart';
import '../dtos.dart';

extension SalariosMapper on SalariosDto {
  Salarios toSalario() {
    return Salarios(
      id: id,
      empregoId: empregoId!,
      vigencia: parseVigencia(vigencia!),
      valor: valor?.toDouble() ?? 0.0,
      ativo: ativo ?? false,
    );
  }

  static SalariosDto fromJson(Map<String, dynamic> json) {
    return SalariosDto(
      id: json['id'] as String,
      empregoId: json['emprego_id'] as String,
      vigencia: json['vigencia'],
      valor: json['valor'] as num,
      ativo: json['ativo'] as bool,
      createdAt: json['created_at'] is int
          ? getDateFromMillis(json['created_at'])
          : parseDate(json['created_at']),
    );
  }

  static List<SalariosDto> fromJsonList(dynamic salarios) {
    if (salarios.isEmpty) return [];
    return salarios.map<SalariosDto>((it) => fromJson(it)).toList();
  }

  // Method to convert SalariosDto instance to a JSON object
  Map<String, dynamic> toJson() {
    final salarioMap = {
      'emprego_id': empregoId,
      'vigencia': vigencia,
      'valor': valor.toString(),
      'ativo': ativo,
    };

    if (id != null) {
      salarioMap['id'] = id;
    }

    return salarioMap;
  }

  DbSalariosCompanion toCompanion({
    String? newId,
  }) {
    return DbSalariosCompanion(
      id: Value(newId ?? id!),
      empregoId: Value(empregoId!),
      vigencia: Value(vigencia!),
      valor: Value(valor?.toDouble() ?? 0.0),
      ativo: Value(ativo ?? false),
    );
  }
}

extension SalariosDtoMapper on Salarios {
  SalariosDto toSalarioDto() {
    return SalariosDto(
      id: id,
      empregoId: empregoId,
      vigencia: formatVigenciaDate(vigencia),
      valor: valor.toDouble(),
      ativo: ativo,
    );
  }
}
