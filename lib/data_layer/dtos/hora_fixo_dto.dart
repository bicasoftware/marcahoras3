import 'package:flutter/foundation.dart';

@immutable
class HoraFixoDto {
  final String? id;
  final String? idEmprego;
  final double? valorNormal;
  final double? valorFeriado;
  final String? vigencia;

  HoraFixoDto({
    required this.id,
    required this.idEmprego,
    required this.valorNormal,
    required this.valorFeriado,
    required this.vigencia,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_emprego': idEmprego,
      'valor_normal': valorNormal,
      'valor_feriado': valorFeriado,
      'vigencia': vigencia,
    };
  }

  factory HoraFixoDto.fromJson(Map<String, dynamic> json) {
    return HoraFixoDto(
      id: json['id'],
      idEmprego: json['id_emprego'],
      valorNormal: json['valor_normal'],
      valorFeriado: json['valor_feriado'],
      vigencia: json['vigencia'],
    );
  }

  static List<HoraFixoDto> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => HoraFixoDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  HoraFixoDto copyWith({
    String? id,
    String? idEmprego,
    double? valorNormal,
    double? valorFeriado,
    String? vigencia,
  }) {
    return HoraFixoDto(
      id: id ?? this.id,
      idEmprego: idEmprego ?? this.idEmprego,
      valorNormal: valorNormal ?? this.valorNormal,
      valorFeriado: valorFeriado ?? this.valorFeriado,
      vigencia: vigencia ?? this.vigencia,
    );
  }
}
