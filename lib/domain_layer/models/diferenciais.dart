import 'package:flutter/material.dart';

import '../../data_layer/dtos.dart';
import '../../resources.dart';

@immutable
class Diferenciais {
  final String? id;
  final String idEmprego;
  final int weekday;
  final int percentage;
  final Color color;

  Diferenciais({
    this.id,
    required this.idEmprego,
    required this.weekday,
    required this.percentage,
    required this.color,
  });

  factory Diferenciais.fromDTO(DiferenciaisDto dto) {
    return Diferenciais(
      id: dto.id,
      idEmprego: dto.idEmprego ?? '',
      weekday: dto.weekday ?? 0,
      percentage: dto.percentage ?? 50,
      color: dto.color != null
          ? Color(int.parse(dto.color!))
          : ExtraColors.porcDiferenciadaColor,
    );
  }

  Diferenciais copyWith({
    String? id,
    String? idEmprego,
    int? weekday,
    int? percentage,
    Color? color,
  }) {
    return Diferenciais(
      id: id ?? this.id,
      idEmprego: idEmprego ?? this.idEmprego,
      weekday: weekday ?? this.weekday,
      percentage: percentage ?? this.percentage,
      color: color ?? this.color,
    );
  }

  @override
  bool operator ==(covariant Diferenciais other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
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
    return 'Diferenciais(id: $id, idEmprego: $idEmprego, weekday: $weekday, percentage: $percentage, color: $color)';
  }
}
