class DiferenciaisDTO {
  final String id;
  final String idEmprego;
  final int weekday;
  final int percentage;

  DiferenciaisDTO({
    required this.id,
    required this.idEmprego,
    required this.weekday,
    required this.percentage,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_emprego': idEmprego,
      'weekday': weekday,
      'percentage': percentage,
    };
  }

  factory DiferenciaisDTO.fromJson(Map<String, dynamic> json) {
    return DiferenciaisDTO(
      id: json['id'],
      idEmprego: json['id_emprego'],
      weekday: json['weekday'],
      percentage: json['percentage'],
    );
  }

  DiferenciaisDTO copyWith({
    String? id,
    String? idEmprego,
    int? weekday,
    int? percentage,
  }) {
    return DiferenciaisDTO(
      id: id ?? this.id,
      idEmprego: idEmprego ?? this.idEmprego,
      weekday: weekday ?? this.weekday,
      percentage: percentage ?? this.percentage,
    );
  }
}