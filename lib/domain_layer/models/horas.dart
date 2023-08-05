import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Horas extends Equatable {
  final int id;
  final int empregoId;
  final int tipoHora;
  final bool bancoHoras;
  final DateTime data;

  const Horas({
    required this.id,
    required this.empregoId,
    required this.tipoHora,
    required this.bancoHoras,
    required this.data,
  });

  @override
  List<Object?> get props => [id, empregoId, tipoHora, bancoHoras, data];

  factory Horas.fromJson(Map<String, dynamic> json) {
    return Horas(
      id: json['id'] as int,
      empregoId: json['emprego_id'] as int,
      tipoHora: json['tipo_hora'] as int,
      bancoHoras: json['banco_horas'] as bool,
      data: DateTime.parse(json['data'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emprego_id': empregoId,
      'tipo_hora': tipoHora,
      'banco_horas': bancoHoras,
      'data': data.toIso8601String(),
    };
  }

  Horas copyWith({
    int? id,
    int? empregoId,
    int? tipoHora,
    bool? bancoHoras,
    DateTime? data,
  }) {
    return Horas(
      id: id ?? this.id,
      empregoId: empregoId ?? this.empregoId,
      tipoHora: tipoHora ?? this.tipoHora,
      bancoHoras: bancoHoras ?? this.bancoHoras,
      data: data ?? this.data,
    );
  }
}
