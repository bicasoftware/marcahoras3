import 'package:flutter/foundation.dart';

@immutable
class HoraFixoDto {
  final String? id;
  final String? idEmprego;
  final num? valorNormal;
  final num? valorFeriado;
  final String? vigencia;

  const HoraFixoDto({
    required this.id,
    required this.idEmprego,
    required this.valorNormal,
    required this.valorFeriado,
    required this.vigencia,
  });

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

  @override
  bool operator ==(covariant HoraFixoDto other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.idEmprego == idEmprego &&
        other.valorNormal == valorNormal &&
        other.valorFeriado == valorFeriado &&
        other.vigencia == vigencia;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idEmprego.hashCode ^
        valorNormal.hashCode ^
        valorFeriado.hashCode ^
        vigencia.hashCode;
  }

  @override
  String toString() {
    return 'HoraFixoDto(id: $id, idEmprego: $idEmprego, valorNormal: $valorNormal, valorFeriado: $valorFeriado, vigencia: $vigencia)';
  }
}
