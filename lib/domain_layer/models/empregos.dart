import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../models.dart';

@immutable
class Empregos extends Equatable {
  final int id;
  final String descricao;
  final DateTime admissao;
  final TimeOfDay entrada;
  final TimeOfDay saida;
  final bool bancoHoras;
  final int porcFeriado;
  final int porcNormal;
  final int cargaHoraria;
  final bool ativo;

  final UnmodifiableListView<Horas> horas;
  final UnmodifiableListView<Salarios> salarios;

  Empregos({
    required this.id,
    required this.descricao,
    required this.admissao,
    required this.entrada,
    required this.saida,
    required this.bancoHoras,
    required this.porcFeriado,
    required this.porcNormal,
    required this.cargaHoraria,
    required this.ativo,
    Iterable<Horas> horas = const [],
    Iterable<Salarios> salarios = const [],
  })  : horas = UnmodifiableListView(horas),
        salarios = UnmodifiableListView(salarios);

  Empregos copyWith({
    int? id,
    String? descricao,
    DateTime? admissao,
    TimeOfDay? entrada,
    TimeOfDay? saida,
    bool? bancoHoras,
    int? porcFeriado,
    int? porcNormal,
    int? cargaHoraria,
    bool? ativo,
    Iterable<Horas>? horas,
    Iterable<Salarios>? salarios,
  }) {
    return Empregos(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      admissao: admissao ?? this.admissao,
      entrada: entrada ?? this.entrada,
      saida: saida ?? this.saida,
      bancoHoras: bancoHoras ?? this.bancoHoras,
      porcFeriado: porcFeriado ?? this.porcFeriado,
      porcNormal: porcNormal ?? this.porcNormal,
      cargaHoraria: cargaHoraria ?? this.cargaHoraria,
      ativo: ativo ?? this.ativo,
      horas: horas ?? this.horas,
      salarios: salarios ?? this.salarios,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      descricao,
      admissao,
      entrada,
      saida,
      bancoHoras,
      porcFeriado,
      porcNormal,
      cargaHoraria,
      ativo,
    ];
  }
}
