import '../../data_layer/dtos.dart';

class Diferenciais {
  final String? id;
  final String idEmprego;
  final int weekday;
  final int percentage;

  Diferenciais({
    this.id,
    required this.idEmprego,
    required this.weekday,
    required this.percentage,
  });

  factory Diferenciais.fromDTO(DiferenciaisDto dto) {
    return Diferenciais(
      id: dto.id,
      idEmprego: dto.idEmprego,
      weekday: dto.weekday,
      percentage: dto.percentage,
    );
  }

  DiferenciaisDto toDTO() {
    return DiferenciaisDto(
      id: id!,
      idEmprego: idEmprego,
      weekday: weekday,
      percentage: percentage,
    );
  }

  Diferenciais copyWith({
    String? id,
    String? idEmprego,
    int? weekday,
    int? percentage,
  }) {
    return Diferenciais(
      id: id ?? this.id,
      idEmprego: idEmprego ?? this.idEmprego,
      weekday: weekday ?? this.weekday,
      percentage: percentage ?? this.percentage,
    );
  }
}
