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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emprego_id': idEmprego,
      'weekday': weekday,
      'percentage': percentage,
      'color': color,
    };
  }

  factory DiferenciaisDto.fromJson(Map<String, dynamic> json) {
    return DiferenciaisDto(
      id: json['id'],
      idEmprego: json['id_emprego'],
      weekday: json['weekday'],
      percentage: json['percentage'],
      color: json['color'],
    );
  }

  static List<Map<String, dynamic>> toJsonList(List<DiferenciaisDto> list) {
    return list.map((d) => d.toJson()).toList();
  }

  static List<DiferenciaisDto> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => DiferenciaisDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }

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
}
