import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../models.dart';

@immutable
class Empregos extends Equatable {
  final String? id;
  final String descricao;
  final DateTime? admissao;
  final TimeOfDay entrada;
  final TimeOfDay saida;
  final bool bancoHoras;
  final int porcFeriado;
  final int porcNormal;
  final int cargaHoraria;
  final bool ativo;

  final double salario;

  final UnmodifiableListView<Horas> horas;
  final UnmodifiableListView<Salarios> salarios;

  Empregos({
    this.id,
    this.descricao = '',
    this.admissao,
    this.entrada = const TimeOfDay(hour: 8, minute: 0),
    this.saida = const TimeOfDay(hour: 18, minute: 0),
    this.bancoHoras = false,
    this.porcFeriado = 100,
    this.porcNormal = 50,
    this.cargaHoraria = 220,
    this.ativo = true,
    this.salario = 0.0,
    Iterable<Horas> horas = const [],
    Iterable<Salarios> salarios = const [],
  })  : horas = UnmodifiableListView(horas),
        salarios = UnmodifiableListView(salarios);

  Empregos copyWith({
    String? id,
    String? descricao,
    DateTime? admissao,
    TimeOfDay? entrada,
    TimeOfDay? saida,
    bool? bancoHoras,
    int? porcFeriado,
    int? porcNormal,
    int? cargaHoraria,
    bool? ativo,
    double? salario,
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
      salario: salario ?? this.salario,
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
      salario,
    ];
  }
}
