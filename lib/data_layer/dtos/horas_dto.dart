import 'package:flutter/foundation.dart';

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

  @override
  bool operator ==(covariant HorasDto other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.empregoId == empregoId &&
        other.data == data &&
        other.inicio == inicio &&
        other.termino == termino &&
        other.tipoHora == tipoHora &&
        other.createdAt == createdAt &&
        other.horaStatus == horaStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        empregoId.hashCode ^
        data.hashCode ^
        inicio.hashCode ^
        termino.hashCode ^
        tipoHora.hashCode ^
        createdAt.hashCode ^
        horaStatus.hashCode;
  }

  @override
  String toString() {
    return 'HorasDto(id: $id, empregoId: $empregoId, data: $data, inicio: $inicio, termino: $termino, tipoHora: $tipoHora, createdAt: $createdAt, horaStatus: $horaStatus)';
  }
}
