import 'package:flutter/foundation.dart';

@immutable
class Feriados {
  final DateTime data;
  final String nome;

  const Feriados({
    required this.data,
    required this.nome,
  });

  @override
  bool operator ==(covariant Feriados other) {
    if (identical(this, other)) return true;

    return other.data == data && other.nome == nome;
  }

  @override
  int get hashCode => data.hashCode ^ nome.hashCode;

  @override
  String toString() => 'Feriados(data: $data, nome: $nome)';
}
