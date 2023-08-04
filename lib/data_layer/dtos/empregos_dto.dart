import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
class EmpregosDTO extends Equatable {
  final String? descricao;
  final String? inicio;
  final String? entrada;
  final String? saida;
  final int? extra;
  final int? extraFeriado;
  final int? cargaHoraria;

  const EmpregosDTO({
    required this.descricao,
    required this.inicio,
    required this.entrada,
    required this.saida,
    required this.extra,
    required this.extraFeriado,
    required this.cargaHoraria,
  });

  Map<String, dynamic> toJson() {
    return {
      'descricao': descricao,
      'inicio': inicio,
      'entrada': entrada,
      'saida': saida,
      'extra': extra,
      'extra_feriado': extraFeriado,
      'carga_horaria': cargaHoraria,
    };
  }

  factory EmpregosDTO.fromJson(Map<String, dynamic> json) {
    return EmpregosDTO(
      descricao: json['descricao'],
      inicio: json['inicio'],
      entrada: json['entrada'],
      saida: json['saida'],
      extra: json['extra'],
      extraFeriado: json['extra_feriado'],
      cargaHoraria: json['carga_horaria'],
    );
  }

  EmpregosDTO copyWith({
    String? descricao,
    String? inicio,
    String? entrada,
    String? saida,
    int? extra,
    int? extraFeriado,
    int? cargaHoraria,
  }) {
    return EmpregosDTO(
      descricao: descricao ?? this.descricao,
      inicio: inicio ?? this.inicio,
      entrada: entrada ?? this.entrada,
      saida: saida ?? this.saida,
      extra: extra ?? this.extra,
      extraFeriado: extraFeriado ?? this.extraFeriado,
      cargaHoraria: cargaHoraria ?? this.cargaHoraria,
    );
  }

  // TODO - mover isso pra uma extension
  String toSQLTableString() {
    return '''
      CREATE TABLE IF NOT EXISTS empregos (
        descricao TEXT,
        inicio TEXT,
        entrada TEXT,
        saida TEXT,
        extra INTEGER,
        extra_feriado INTEGER,
        carga_horaria INTEGER
      );
    ''';
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
