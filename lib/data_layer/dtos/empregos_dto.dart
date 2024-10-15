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
  final List<HorasDto>? horas;
  final List<SalariosDto>? salarios;

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
    this.horas,
    this.salarios,
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
      admissao: map['admissao'],
      entrada: map['entrada'],
      saida: map['saida'],
      bancoHoras:
          map['banco_horas'] != null ? map['banco_horas'] as bool : null,
      porcNormal: map['porc_normal'],
      porcFeriado: map['porc_feriado'],
      ativo: map['ativo'] != null ? map['ativo'] as bool : null,
      cargaHoraria: map['carga_horaria'],
      horas: map['horas'] != null ? HorasDto.fromJsonList(map['horas']) : [],
      salarios: map['salarios'] != null
          ? SalariosDto.fromJsonList(map['salarios'])
          : [],
    );

    return emprego;
  }

  static List<EmpregosDto> fromJsonList(List<dynamic> data) {
    return data.map((e) => EmpregosDto.fromJson(e)).toList();
  }
}
