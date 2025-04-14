class HoraFixoDTO {
  final String id;
  final String idEmprego;
  final double value;
  final String vigencia;

  HoraFixoDTO({
    required this.id,
    required this.idEmprego,
    required this.value,
    required this.vigencia,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_emprego': idEmprego,
      'value': value,
      'vigencia': vigencia,
    };
  }

  factory HoraFixoDTO.fromJson(Map<String, dynamic> json) {
    return HoraFixoDTO(
      id: json['id'],
      idEmprego: json['id_emprego'],
      value: json['value'],
      vigencia: json['vigencia'],
    );
  }  

  HoraFixoDTO copyWith({
    String? id,
    String? idEmprego,
    double? value,
    String? vigencia,
  }) {
    return HoraFixoDTO(
      id: id ?? this.id,
      idEmprego: idEmprego ?? this.idEmprego,
      value: value ?? this.value,
      vigencia: vigencia ?? this.vigencia,
    );
  }
}