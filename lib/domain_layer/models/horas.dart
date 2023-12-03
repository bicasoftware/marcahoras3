import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Horas extends Equatable {
  final int id;
  final int empregoId;
  final DateTime data;
  final String inicio;
  final String termino;
  final HorasType tipoHora;
  final bool bancoHoras;

  const Horas({
    required this.id,
    required this.empregoId,
    required this.data,
    required this.inicio,
    required this.termino,
    required this.tipoHora,
    required this.bancoHoras,
  });

  @override
  List<Object> get props {
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

  @override
  bool get stringify => true;

  Horas copyWith({
    int? id,
    int? empregoId,
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
  normal('n'),
  feriado('f'),
  unknown('u');

  final String letter;

  const HorasType(this.letter);

  static fromLetter(String? letter) {
    if (letter == null) return HorasType.unknown;

    return values.firstWhere((HorasType it) => it.letter == letter,
        orElse: () => HorasType.unknown);
  }
}
