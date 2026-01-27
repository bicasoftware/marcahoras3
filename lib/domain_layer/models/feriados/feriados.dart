class Feriados {
  final DateTime date;
  final String name;
  final String type;

  const Feriados({
    required this.date,
    required this.name,
    required this.type,
  });

  Feriados copyWith({
    DateTime? date,
    String? name,
    String? type,
  }) {
    return Feriados(
      date: date ?? this.date,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  @override
  String toString() => 'Feriado(date: $date, name: $name, type: $type)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Feriados &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          name == other.name &&
          type == other.type;

  @override
  int get hashCode => Object.hash(date, name, type);
}