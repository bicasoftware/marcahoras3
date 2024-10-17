import 'package:flutter/foundation.dart';

import '../../utils/utils.dart';

@immutable
class HorasDto {
  final String? id;
  final String? empregoId;
  final DateTime? data;
  final String? inicio;
  final String? termino;
  final String? tipoHora;
  final bool? bancoHoras;

  const HorasDto({
    this.id,
    this.empregoId,
    this.data,
    this.inicio,
    this.termino,
    this.tipoHora,
    this.bancoHoras,
  });

  JsonObj toJson() {
    final map = <String, dynamic>{
      'emprego_id': empregoId,
      'data': formatDate(data!, true),
      'inicio': inicio,
      'termino': termino,
      'tipo_hora': tipoHora,
      'banco_horas': bancoHoras,
    };

    if (id != null) map['id'] = id;

    return map;
  }

  factory HorasDto.fromJson(JsonObj map) {
    return HorasDto(
      id: map['id'] != null ? map['id'] as String : "",
      empregoId: map['emprego_id'] != null ? map['emprego_id'] as String : "",
      data: parseDate(map['data']),
      inicio: map['inicio'] != null ? map['inicio'] as String : null,
      termino: map['termino'] != null ? map['termino'] as String : null,
      tipoHora: map['tipo_hora'] != null ? map['tipo_hora'] as String : null,
      bancoHoras:
          map['banco_horas'] != null ? map['banco_horas'] as bool : null,
    );
  }

  static List<HorasDto> fromJsonList(dynamic list) {
    if (list.isEmpty) return [];
    return list.map<HorasDto>((h) => HorasDto.fromJson(h)).toList();
  }

  @override
  String toString() {
    return 'HorasDto(id: $id, empregoId: $empregoId, data: $data, inicio: $inicio, termino: $termino, tipoHora: $tipoHora, bancoHoras: $bancoHoras)';
  }
}
