import 'package:flutter/foundation.dart';

@immutable
class DiferenciaisDto {
  final String? id;
  final String? idEmprego;
  final int? weekday;
  final int? percentage;
  final String? color;

  DiferenciaisDto({
    required this.id,
    required this.idEmprego,
    required this.weekday,
    required this.percentage,
    required this.color,
  });

  DiferenciaisDto copyWith({
    String? id,
    String? idEmprego,
    int? weekday,
    int? percentage,
    String? color,
  }) {
    return DiferenciaisDto(
      id: id ?? this.id,
      idEmprego: idEmprego ?? this.idEmprego,
      weekday: weekday ?? this.weekday,
      percentage: percentage ?? this.percentage,
      color: color ?? this.color,
    );
  }

  @override
  bool operator ==(covariant DiferenciaisDto other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.idEmprego == idEmprego &&
        other.weekday == weekday &&
        other.percentage == percentage &&
        other.color == color;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idEmprego.hashCode ^
        weekday.hashCode ^
        percentage.hashCode ^
        color.hashCode;
  }

  @override
  String toString() {
    return 'DiferenciaisDto(id: $id, idEmprego: $idEmprego, weekday: $weekday, percentage: $percentage, color: $color)';
  }
}
