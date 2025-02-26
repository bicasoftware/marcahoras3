import 'package:flutter/foundation.dart';

@immutable
class SalariosDto {
  final String? id;
  final String? empregoId;
  final String? vigencia;
  final num? valor;
  final bool? ativo;

  const SalariosDto({
    this.id,
    this.empregoId,
    required this.vigencia,
    required this.valor,
    required this.ativo,
  });

  // Factory method to create a SalariosDto instance from a JSON object
  factory SalariosDto.fromJson(Map<String, dynamic> json) {
    return SalariosDto(
      id: json['id'] as String,
      empregoId: json['emprego_id'] as String,
      vigencia: json['vigencia'],
      valor: json['valor'] as num,
      ativo: json['ativo'] as bool,
    );
  }

  static List<SalariosDto> fromJsonList(dynamic salarios) {
    if (salarios.isEmpty) return [];
    return salarios.map<SalariosDto>((it) => SalariosDto.fromJson(it)).toList();
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

  SalariosDto copyWith({String? id, String? empregoId}) {
    return SalariosDto(
      id: id ?? this.id,
      ativo: ativo,
      empregoId: empregoId ?? this.empregoId,
      valor: valor,
      vigencia: vigencia,
    );
  }
}
