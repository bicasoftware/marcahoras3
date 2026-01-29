import 'package:flutter/foundation.dart';

@immutable
class FeriadosDto {
  final DateTime? data;
  final String? nome;

  const FeriadosDto({
    required this.data,
    required this.nome,
  });

  @override
  bool operator ==(covariant FeriadosDto other) {
    if (identical(this, other)) return true;

    return other.data == data && other.nome == nome;
  }

  @override
  int get hashCode => data.hashCode ^ nome.hashCode;

  @override
  String toString() => 'FeriadosDto(data: $data, nome: $nome)';
}
