import 'package:flutter/foundation.dart';

import '../../../utils.dart';

@immutable
class FeriadosDto {
  final DateTime? date;
  final String? name;
  final String? type;

  FeriadosDto({
    required this.date,
    required this.name,
    required this.type,
  });

  factory FeriadosDto.fromJson(Map<String, dynamic> json) {
    return FeriadosDto(
      date: json['date'] is int
          ? getDateFromMillis(json['date'])
          : parseDate(json['date']),
      name: json['name'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson(FeriadosDto feriado) {
    return {
      'date': formatDate(date!, true),
      'name': feriado.name,
      'type': feriado.type,
    };
  }

  static List<FeriadosDto> fromJsonList(List<dynamic> jsonArray) {
    return jsonArray.map((json) => FeriadosDto.fromJson(json)).toList();
  }

  @override
  String toString() => 'FeriadosDto(date: $date, name: $name, type: $type)';

  @override
  bool operator ==(covariant FeriadosDto other) {
    if (identical(this, other)) return true;

    return other.date == date && other.name == name && other.type == type;
  }

  @override
  int get hashCode => date.hashCode ^ name.hashCode ^ type.hashCode;
}
