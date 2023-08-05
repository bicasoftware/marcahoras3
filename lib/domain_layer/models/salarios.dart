import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Salarios extends Equatable {
  final int id;
  final int empregoId;
  final double valor;
  final DateTime inicio;

  const Salarios({
    required this.id,
    required this.empregoId,
    required this.valor,
    required this.inicio,
  });

  @override
  List<Object?> get props => [id, empregoId, valor, inicio];

  Salarios copyWith({
    int? id,
    int? empregoId,
    double? valor,
    DateTime? inicio,
  }) {
    return Salarios(
      id: id ?? this.id,
      empregoId: empregoId ?? this.empregoId,
      valor: valor ?? this.valor,
      inicio: inicio ?? this.inicio,
    );
  }

  factory Salarios.fromJson(Map<String, dynamic> json) {
    return Salarios(
      id: json['id'],
      empregoId: json['emprego_id'],
      valor: json['valor'],
      inicio: DateTime.parse(json['inicio']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emprego_id': empregoId,
      'valor': valor,
      'inicio': inicio.toIso8601String(),
    };
  }
}
