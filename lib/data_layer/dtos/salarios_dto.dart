import 'package:flutter/foundation.dart';

import '../../utils/utils.dart';

@immutable
class SalariosDto {
  final int? id;
  final int? empregoId;
  final DateTime? vigencia;
  final num? valor;
  final bool? ativo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SalariosDto({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.empregoId,
    required this.vigencia,
    required this.valor,
    required this.ativo,
  });

  // Factory method to create a SalariosDto instance from a JSON object
  factory SalariosDto.fromJson(Map<String, dynamic> json) {
    return SalariosDto(
      id: json['id'] as int,
      createdAt: parseDate(json['created_at']),
      updatedAt: parseDate(json['updated_at']),
      empregoId: json['emprego_id'] as int,
      vigencia: parseDate(json['vigencia']),
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
    return {
      'id': id,
      'emprego_id': empregoId,
      'vigencia': vigencia,
      'valor': valor,
      'ativo': ativo,
    };
  }

  // Override toString for easy debugging
  @override
  String toString() {
    return 'Salario{id: $id, createdAt: $createdAt, updatedAt: $updatedAt, '
        'empregoId: $empregoId, vigencia: $vigencia, valor: $valor, ativo: $ativo}';
  }
}