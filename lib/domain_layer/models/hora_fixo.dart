import 'package:flutter/foundation.dart';

@immutable
class HoraFixo {
  final String? id;
  final String idEmprego;
  final double valorNormal;
  final double valorFeriado;
  final DateTime vigencia;

  HoraFixo({
    this.id,
    required this.idEmprego,
    required this.valorNormal,
    required this.valorFeriado,
    required this.vigencia,
  });

  HoraFixo copyWith({
    String? id,
    String? idEmprego,
    double? value,
    double? valorNormal,
    double? valorFeriado,
    DateTime? vigencia,
  }) {
    return HoraFixo(
      id: id ?? this.id,
      idEmprego: idEmprego ?? this.idEmprego,
      valorNormal: valorNormal ?? this.valorNormal,
      valorFeriado: valorFeriado ?? this.valorFeriado,
      vigencia: vigencia ?? this.vigencia,
    );
  }
}
