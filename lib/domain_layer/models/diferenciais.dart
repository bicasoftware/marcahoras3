import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Diferenciais extends Equatable {
  final int id;
  final int empregoId;
  final int porcentagem;
  final DateTime inicio;
  final int weekday;

  const Diferenciais({
    required this.id,
    required this.empregoId,
    required this.porcentagem,
    required this.inicio,
    required this.weekday,
  });

  Diferenciais copyWith({
    int? id,
    int? empregoId,
    int? porcentagem,
    DateTime? inicio,
    int? weekday,
  }) {
    return Diferenciais(
      id: id ?? this.id,
      empregoId: empregoId ?? this.empregoId,
      porcentagem: porcentagem ?? this.porcentagem,
      inicio: inicio ?? this.inicio,
      weekday: weekday ?? this.weekday,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emprego_id': empregoId,
      'porcentagem': porcentagem,
      'inicio': inicio.toIso8601String(),
      'weekday': weekday,
    };
  }

  factory Diferenciais.fromJson(Map<String, dynamic> json) {
    return Diferenciais(
      id: json['id'],
      empregoId: json['emprego_id'],
      porcentagem: json['porcentagem'],
      inicio: DateTime.parse(json['inicio']),
      weekday: json['weekday'],
    );
  }

  @override
  List<Object?> get props => [id, empregoId, porcentagem, inicio, weekday];
}

