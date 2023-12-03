import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Salarios extends Equatable {
  final int id;
  final int empregoId;
  final DateTime vigencia;
  final double valor;
  final bool ativo;

  const Salarios({
    required this.id,
    required this.empregoId,
    required this.vigencia,
    required this.valor,
    required this.ativo,
  });

  @override
  List<Object> get props {
    return [
      id,
      empregoId,
      vigencia,
      valor,
      ativo,
    ];
  }

  Salarios copyWith({
    int? id,
    int? empregoId,
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
    );
  }
}
