import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Horas extends Equatable {
  final String? id;
  final String empregoId;
  final DateTime data;
  final String inicio;
  final String termino;
  final HorasType tipoHora;
  final bool bancoHoras;

  const Horas({
    this.id,
    required this.empregoId,
    required this.data,
    required this.inicio,
    required this.termino,
    required this.tipoHora,
    required this.bancoHoras,
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
      bancoHoras,
    ];
  }

  Horas copyWith({
    String? id,
    String? empregoId,
    DateTime? data,
    String? inicio,
    String? termino,
    HorasType? tipoHora,
    bool? bancoHoras,
  }) {
    return Horas(
      id: id ?? this.id,
      empregoId: empregoId ?? this.empregoId,
      data: data ?? this.data,
      inicio: inicio ?? this.inicio,
      termino: termino ?? this.termino,
      tipoHora: tipoHora ?? this.tipoHora,
      bancoHoras: bancoHoras ?? this.bancoHoras,
    );
  }
}

enum HorasType {
  normal('n', 0xFF5FB800),
  feriado('f', 0xFFFF847D),
  unknown('u', 0xFF8F8F8F);

  final String letter;
  final int colorHex;

  const HorasType(this.letter, this.colorHex);

  static fromLetter(String? letter) {
    if (letter == null) return HorasType.unknown;

    return values.firstWhere((HorasType it) => it.letter == letter,
        orElse: () => HorasType.unknown);
  }
}
