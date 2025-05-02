import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Horas extends Equatable {
  final String? id;
  final String empregoId;
  final DateTime data;
  final TimeOfDay inicio;
  final TimeOfDay termino;
  final HorasType tipoHora;
  final HoraStatus horaStatus;
  final DateTime createdAt;

  const Horas({
    this.id,
    required this.empregoId,
    required this.data,
    required this.inicio,
    required this.termino,
    required this.tipoHora,
    required this.createdAt,
    required this.horaStatus,
  });

  @override
  List<Object?> get props {
    return [
      id,
      empregoId,
      data,
      inicio,
      termino,
      tipoHora,
      createdAt,
      horaStatus,
    ];
  }

  Horas copyWith({
    String? id,
    String? empregoId,
    DateTime? data,
    TimeOfDay? inicio,
    TimeOfDay? termino,
    HorasType? tipoHora,
    HoraStatus? horaStatus,
  }) {
    return Horas(
      id: id ?? this.id,
      empregoId: empregoId ?? this.empregoId,
      data: data ?? this.data,
      inicio: inicio ?? this.inicio,
      termino: termino ?? this.termino,
      tipoHora: tipoHora ?? this.tipoHora,
      horaStatus: horaStatus ?? this.horaStatus,
      createdAt: createdAt,
    );
  }
}

enum HorasType {
  normal('n', 0xFF5FB800),
  feriado('f', 0xFFFF847D),
  banco('b', 0xFF29BDFC),
  diferencial('d', 0xFFFF847D),
  unknown('u', 0xFF8F8F8F);

  final String letter;
  final int colorHex;

  const HorasType(this.letter, this.colorHex);

  static fromLetter(String? letter) {
    if (letter == null) return HorasType.unknown;

    return values.firstWhere(
      (HorasType it) => it.letter == letter,
      orElse: () => HorasType.unknown,
    );
  }
}

enum HoraStatus {
  active('a', 0xFF29BDFC),
  burned('b', 0xFFFF847D),
  received('r', 0xFF5FB800),
  partial('p', 0xFF5FB800),
  unknown('u', 0xFF5FB800);

  final String letter;
  final int color;

  const HoraStatus(this.letter, this.color);

  static fromLetter(String? letter) {
    if (letter == null) return HoraStatus.unknown;

    return values.firstWhere(
      (HoraStatus it) => it.letter == letter,
      orElse: () => HoraStatus.unknown,
    );
  }
}
