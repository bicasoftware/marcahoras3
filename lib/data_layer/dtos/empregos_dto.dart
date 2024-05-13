import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import '../../utils/utils.dart';
import '../dtos.dart';

@immutable
class EmpregosDTO extends Equatable {
  final String? id;
  final String? descricao;
  final DateTime? admissao;
  final String? entrada;
  final String? saida;
  final bool? bancoHoras;
  final int? porcNormal;
  final int? porcFeriado;
  final bool? ativo;
  final int? cargaHoraria;
  final List<HorasDto>? horas;
  final List<SalariosDto>? salarios;

  final DateTime? createAt;
  final DateTime? updatedAt;

  const EmpregosDTO({
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
    this.createAt,
    this.updatedAt,
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
      createAt,
      updatedAt,
    ];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'descricao': descricao,
      'admissao': admissao?.millisecondsSinceEpoch,
      'entrada': entrada,
      'saida': saida,
      'banco_horas': bancoHoras,
      'porc_normal': porcNormal,
      'porc_feriado': porcFeriado,
      'ativo': ativo,
      'carga_horaria': cargaHoraria,
    };
  }

  factory EmpregosDTO.fromJson(Map<String, dynamic> map) {
    final emprego = EmpregosDTO(
      id: map['id'],
      descricao: map['descricao'],
      admissao: parseDate(map['admissao']),
      entrada: parseTime(map['entrada'])!.toTimeStr(),
      saida: parseTime(map['saida'])!.toTimeStr(),
      bancoHoras:
          map['banco_horas'] != null ? map['banco_horas'] as bool : null,
      porcNormal: map['porc_normal'],
      porcFeriado: map['porc_feriado'],
      ativo: map['ativo'] != null ? map['ativo'] as bool : null,
      cargaHoraria: map['carga_horaria'],
      createAt: parseDate(map['created_at'], withTime: true)!,
      updatedAt: parseDate(map['updated_at'], withTime: true)!,
      horas: map['horas'] != null ? HorasDto.fromJsonList(map['horas']) : [],
      salarios: map['salarios'] != null
          ? SalariosDto.fromJsonList(map['salarios'])
          : [],
    );

    return emprego;
  }

  static List<EmpregosDTO> fromJsonList(JsonList data) {
    return data.map((e) => EmpregosDTO.fromJson(e)).toList();
  }
}
