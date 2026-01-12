import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:marcahoras3/utils.dart';

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

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'descricao': descricao,
      'admissao': admissao,
      'entrada': entrada,
      'saida': saida,
      'banco_horas': bancoHoras,
      'porc_normal': porcNormal,
      'porc_feriado': porcFeriado,
      'ativo': ativo,
      'carga_horaria': cargaHoraria,
      'dia_fechamento': diaFechamento,
    };

    if (id != null) {
      data['id'] = id;
    }

    return data;
  }

  factory EmpregosDto.fromJson(Map<String, dynamic> map) {
    final emprego = EmpregosDto(
      id: map['id'],
      descricao: map['descricao'],
      admissao: map['admissao'] is int
          ? parseDateFromMillis(map['admissao'])
          : map['admissao'] as String,
      entrada: map['entrada'],
      saida: map['saida'],
      bancoHoras: map['banco_horas'] != null
          ? map['banco_horas'] as bool
          : null,
      porcNormal: map['porc_normal'],
      porcFeriado: map['porc_feriado'],
      ativo: map['ativo'] != null ? map['ativo'] as bool : null,
      diaFechamento: map['dia_fechamento'] != null
          ? map['dia_fechamento'] as int
          : null,
      cargaHoraria: map['carga_horaria'],
      horas: map['horas'] != null ? HorasDto.fromJsonList(map['horas']) : [],
      salarios: map['salarios'] != null
          ? SalariosDto.fromJsonList(map['salarios'])
          : [],
      horaFixoList: map['horas_fixo'] != null
          ? HoraFixoDto.fromJsonList(map['horas_fixo'])
          : [],
      diferenciaisList: map['diferenciais'] != null
          ? DiferenciaisDto.fromJsonList(map['diferenciais'])
          : [],
      createdAt: map['created_at'] is int
          ? getDateFromMillis(map['created_at'])
          : parseDate(map['created_at']),
    );

    return emprego;
  }

  static List<EmpregosDto> fromJsonList(List<dynamic> data) {
    return data.map((e) => EmpregosDto.fromJson(e)).toList();
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
