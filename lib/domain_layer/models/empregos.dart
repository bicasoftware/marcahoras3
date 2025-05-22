import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../utils.dart';
import '../models.dart';

@immutable
class Empregos {
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
  final DateTime? createdAt;

  final double salario;

  final UnmodifiableListView<Horas> horas;
  final UnmodifiableListView<Salarios> salarios;
  final UnmodifiableListView<HoraFixo> horaFixoList;

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
    this.createdAt,
    Iterable<Horas> horas = const [],
    Iterable<Salarios> salarios = const [],
    Iterable<HoraFixo> horaFixoList = const [],
  }) : horas = UnmodifiableListView(horas),
       salarios = UnmodifiableListView(salarios),
       horaFixoList = UnmodifiableListView(horaFixoList);

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
    Iterable<HoraFixo>? horaFixoList,
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
      horaFixoList: horaFixoList ?? this.horaFixoList,
      createdAt: createdAt,
    );
  }

  Salarios? getSalarioByVigencia(int year, int month) {
    if (salarios.length == 1) return salarios.first;
    final _vig = DateTime(year, month, 1);
    return salarios
        .sorted((a, b) => a.vigencia.compareTo(b.vigencia))
        .reversed
        .firstWhereOrNull((s) => s.vigencia.isSameDayOfBefore(_vig));
  }

  Salarios? getCurrentSalario() {
    if (salarios.length == 1) {
      return salarios.first;
    }

    return salarios.sorted((a, b) => a.vigencia.compareTo(b.vigencia)).last;
  }

  ValorFixo? getCurrentValorFixo() {
    return horaFixoList
        .sorted((a, b) => a.vigencia.compareTo(b.vigencia))
        .lastOrNull
        ?.toValorFixo();
  }

  @override
  bool operator ==(covariant Empregos other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.descricao == descricao &&
        other.admissao == admissao &&
        other.entrada == entrada &&
        other.saida == saida &&
        other.bancoHoras == bancoHoras &&
        other.porcFeriado == porcFeriado &&
        other.porcNormal == porcNormal &&
        other.cargaHoraria == cargaHoraria &&
        other.ativo == ativo &&
        other.createdAt == createdAt &&
        other.salario == salario &&
        other.horas == horas &&
        other.salarios == salarios &&
        other.horaFixoList == horaFixoList;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        descricao.hashCode ^
        admissao.hashCode ^
        entrada.hashCode ^
        saida.hashCode ^
        bancoHoras.hashCode ^
        porcFeriado.hashCode ^
        porcNormal.hashCode ^
        cargaHoraria.hashCode ^
        ativo.hashCode ^
        createdAt.hashCode ^
        salario.hashCode ^
        horas.hashCode ^
        salarios.hashCode ^
        horaFixoList.hashCode;
  }
}
