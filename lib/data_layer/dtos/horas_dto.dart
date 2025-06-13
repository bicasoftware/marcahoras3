import 'package:flutter/foundation.dart';

import '../../utils.dart';

@immutable
class HorasDto {
  final String? id;
  final String? empregoId;
  final DateTime? data;
  final String? inicio;
  final String? termino;
  final String? tipoHora;
  final DateTime? createdAt;
  final String? horaStatus;

  const HorasDto({
    this.id,
    this.empregoId,
    this.data,
    this.inicio,
    this.termino,
    this.tipoHora,
    this.createdAt,
    this.horaStatus,
  });

  JsonObj toJson() {
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

  factory HorasDto.fromJson(JsonObj map) {
    return HorasDto(
      id: map['id'] != null ? map['id'] as String : "",
      empregoId: map['emprego_id'] != null ? map['emprego_id'] as String : "",
      data: map['data'] is int
          ? getDateFromMillis(map['data'])
          : parseDate(map['data']),
      inicio: map['inicio'] != null ? map['inicio'] as String : null,
      termino: map['termino'] != null ? map['termino'] as String : null,
      tipoHora: map['tipo_hora'] != null ? map['tipo_hora'] as String : null,
      horaStatus: map['status_hora'] != null
          ? map['status_hora'] as String
          : null,
      createdAt: map['created_at'] is int
          ? getDateFromMillis(map['created_at'])
          : parseDate(map['created_at']),
    );
  }

  static List<HorasDto> fromJsonList(dynamic list) {
    if (list.isEmpty) return [];
    return list.map<HorasDto>((h) => HorasDto.fromJson(h)).toList();
  }

  HorasDto copyWithId(String id) {
    return HorasDto(
      id: id,
      empregoId: this.empregoId,
      data: this.data,
      inicio: this.inicio,
      termino: this.termino,
      tipoHora: this.tipoHora,
      horaStatus: this.horaStatus,
    );
  }
}
