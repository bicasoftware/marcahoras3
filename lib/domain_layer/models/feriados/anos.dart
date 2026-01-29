import 'package:flutter/foundation.dart';

import '../../models.dart';

@immutable
class Anos {
  final int ano;
  final List<Feriados> feriados;

  const Anos({
    required this.ano,
    required this.feriados,
  });

  @override
  bool operator ==(covariant Anos other) {
    if (identical(this, other)) return true;

    return other.ano == ano && listEquals(other.feriados, feriados);
  }

  @override
  int get hashCode => ano.hashCode ^ feriados.hashCode;

  @override
  String toString() => 'Anos(ano: $ano, feriados: $feriados)';
}
