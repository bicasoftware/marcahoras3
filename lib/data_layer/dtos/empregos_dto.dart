import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../dtos.dart';

@immutable
class EmpregosDto extends Equatable {
  final String? id;
  final String? descricao;
  final String? admissao;
  final String? entrada;
  final String? saida;
  final bool? bancoHoras;
  final int? porcNormal;
  final int? porcFeriado;
  final bool? ativo;
  final int? cargaHoraria;
  final int? diaFechamento;
  final List<HorasDto> horas;
  final List<SalariosDto> salarios;
  final List<HoraFixoDto> horaFixoList;
  final List<DiferenciaisDto> diferenciaisList;
  final DateTime? createdAt;

  const EmpregosDto({
    this.id,
    this.descricao,
    this.admissao,
    this.entrada,
    this.saida,
    this.bancoHoras,
    this.porcNormal,
    this.porcFeriado,
    this.ativo,
    this.cargaHoraria,
    this.diaFechamento,
    this.createdAt,
    this.horas = const [],
    this.salarios = const [],
    this.horaFixoList = const [],
    this.diferenciaisList = const [],
  });

  @override
  List<Object?> get props {
    return [
      id,
      descricao,
      admissao,
      entrada,
      saida,
      bancoHoras,
      porcNormal,
      porcFeriado,
      ativo,
      cargaHoraria,
      horas,
      salarios,
      diaFechamento,
      horaFixoList,
      diferenciaisList,
      createdAt,
    ];
  }

  EmpregosDto copyWith({
    String? id,
    String? descricao,
    String? admissao,
    String? entrada,
    String? saida,
    bool? bancoHoras,
    int? porcNormal,
    int? porcFeriado,
    bool? ativo,
    int? cargaHoraria,
    int? diaFechamento,
    List<HorasDto>? horas,
    List<SalariosDto>? salarios,
    List<HoraFixoDto>? horaFixoList,
    List<DiferenciaisDto>? diferenciaisList,
  }) {
    return EmpregosDto(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      admissao: admissao ?? this.admissao,
      entrada: entrada ?? this.entrada,
      saida: saida ?? this.saida,
      bancoHoras: bancoHoras ?? this.bancoHoras,
      porcNormal: porcNormal ?? this.porcNormal,
      porcFeriado: porcFeriado ?? this.porcFeriado,
      ativo: ativo ?? this.ativo,
      cargaHoraria: cargaHoraria ?? this.cargaHoraria,
      diaFechamento: diaFechamento ?? this.diaFechamento,
      horas: horas ?? this.horas,
      salarios: salarios ?? this.salarios,
      horaFixoList: horaFixoList ?? this.horaFixoList,
      diferenciaisList: diferenciaisList ?? this.diferenciaisList,
    );
  }
}
