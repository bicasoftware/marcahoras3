import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Empregos extends Equatable {
  final String descricao;
  final DateTime? inicio;
  final TimeOfDay entrada;
  final TimeOfDay saida;
  final int extra;
  final int extraFeriado;
  final int cargaHoraria;

  const Empregos({
    required this.descricao,
    required this.inicio,
    required this.entrada,
    required this.saida,
    required this.extra,
    required this.extraFeriado,
    required this.cargaHoraria,
  });

  Empregos copyWith({
    String? descricao,
    DateTime? inicio,
    TimeOfDay? entrada,
    TimeOfDay? saida,
    int? extra,
    int? extraFeriado,
    int? cargaHoraria,
  }) {
    return Empregos(
      descricao: descricao ?? this.descricao,
      inicio: inicio ?? this.inicio,
      entrada: entrada ?? this.entrada,
      saida: saida ?? this.saida,
      extra: extra ?? this.extra,
      extraFeriado: extraFeriado ?? this.extraFeriado,
      cargaHoraria: cargaHoraria ?? this.cargaHoraria,
    );
  }

  @override
  List<Object?> get props {
    return [
      descricao,
      inicio,
      entrada,
      saida,
      extra,
      extraFeriado,
      cargaHoraria,
    ];
  }
}
