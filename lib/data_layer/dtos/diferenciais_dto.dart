class DiferenciaisDto {
  final String id;
  final String idEmprego;
  final int weekday;
  final int percentage;

  DiferenciaisDto({
    required this.id,
    required this.idEmprego,
    required this.weekday,
    required this.percentage,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emprego_id': idEmprego,
      'weekday': weekday,
      'percentage': percentage,
    };
  }

  factory DiferenciaisDto.fromJson(Map<String, dynamic> json) {
    return DiferenciaisDto(
      id: json['id'],
      idEmprego: json['emprego_id'],
      weekday: json['weekday'],
      percentage: json['percentage'],
    );
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
  }) {
    return DiferenciaisDto(
      id: id ?? this.id,
      idEmprego: idEmprego ?? this.idEmprego,
      weekday: weekday ?? this.weekday,
      percentage: percentage ?? this.percentage,
    );
  }
}
