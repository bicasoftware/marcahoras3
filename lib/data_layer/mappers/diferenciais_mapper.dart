import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../../domain_layer/models.dart';
import '../../resources.dart';
import '../database/db_connector_drift.dart';
import '../dtos.dart';

extension DiferenciaisDtoMapper on DiferenciaisDto {
  Diferenciais toModel() {
    return Diferenciais(
      id: id,
      idEmprego: idEmprego ?? '',
      percentage: percentage ?? 50,
      weekday: weekday ?? 0,
      color: color != null
          ? Color(int.parse(color!))
          : ExtraColors.porcDiferenciadaColor,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emprego_id': idEmprego,
      'weekday': weekday,
      'percentage': percentage,
      'color': color,
    };
  }

  static DiferenciaisDto fromJson(Map<String, dynamic> json) {
    return DiferenciaisDto(
      id: json['id'],
      idEmprego: json['emprego_id'],
      weekday: json['weekday'],
      percentage: json['percentage'],
      color: json['color'],
    );
  }

  static List<Map<String, dynamic>> toJsonList(List<DiferenciaisDto> list) {
    return list.map((d) => d.toJson()).toList();
  }

  static List<DiferenciaisDto> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => DiferenciaisDtoMapper.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  DbDiferenciaisCompanion toCompanion({String? newId}) {
    return DbDiferenciaisCompanion(
      id: Value(newId ?? id!),
      idEmprego: Value(idEmprego!),
      percentage: Value(percentage!),
      weekday: Value(weekday!),
      color: Value(color!),
    );
  }
}

extension DiferenciaisModelMapper on Diferenciais {
  DiferenciaisDto toDto([String? newId]) {
    return DiferenciaisDto(
      id: id,
      idEmprego: idEmprego,
      weekday: weekday,
      percentage: percentage,
      color: color.toARGB32().toString(),
    );
  }
}
