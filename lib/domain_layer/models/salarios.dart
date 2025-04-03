import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Salarios extends Equatable {
  final String? id;
  final String empregoId;
  final DateTime vigencia;
  final double valor;
  final bool ativo;
  final DateTime createdAt;

  const Salarios({
    this.id,
    required this.empregoId,
    required this.vigencia,
    required this.valor,
    required this.ativo,
    required this.createdAt,
  });

  @override
  List<Object?> get props {
    return [id, empregoId, vigencia, valor, ativo, createdAt];
  }

  Salarios copyWith({
    String? id,
    String? empregoId,
    DateTime? vigencia,
    double? valor,
    bool? ativo,
  }) {
    return Salarios(
      id: id ?? this.id,
      empregoId: empregoId ?? this.empregoId,
      vigencia: vigencia ?? this.vigencia,
      valor: valor ?? this.valor,
      ativo: ativo ?? this.ativo,
      createdAt: this.createdAt,
    );
  }
}
