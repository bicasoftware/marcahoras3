import 'package:flutter/foundation.dart';

@immutable
class SalariosDto {
  final String? id;
  final String? empregoId;
  final String? vigencia;
  final num? valor;
  final bool? ativo;
  final DateTime? createdAt;

  const SalariosDto({
    this.id,
    this.empregoId,
    this.createdAt,
    required this.vigencia,
    required this.valor,
    required this.ativo,
  });

  SalariosDto copyWith({String? id, String? empregoId}) {
    return SalariosDto(
      id: id ?? this.id,
      ativo: ativo,
      empregoId: empregoId ?? this.empregoId,
      valor: valor,
      vigencia: vigencia,
      createdAt: createdAt,
    );
  }

  @override
  bool operator ==(covariant SalariosDto other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.empregoId == empregoId &&
      other.vigencia == vigencia &&
      other.valor == valor &&
      other.ativo == ativo &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      empregoId.hashCode ^
      vigencia.hashCode ^
      valor.hashCode ^
      ativo.hashCode ^
      createdAt.hashCode;
  }

  @override
  String toString() {
    return 'SalariosDto(id: $id, empregoId: $empregoId, vigencia: $vigencia, valor: $valor, ativo: $ativo, createdAt: $createdAt)';
  }
}
