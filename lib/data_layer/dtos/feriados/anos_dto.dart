import 'package:flutter/foundation.dart';

import '../../dtos.dart';

@immutable
class AnosDto {
  final int ano;
  final List<FeriadosDto> feriados;

  const AnosDto({required this.ano, required this.feriados});

  @override
  bool operator ==(covariant AnosDto other) {
    if (identical(this, other)) return true;

    return other.ano == ano && listEquals(other.feriados, feriados);
  }

  @override
  int get hashCode => ano.hashCode ^ feriados.hashCode;

  @override
  String toString() => 'AnosDto(ano: $ano, feriados: $feriados)';
}
