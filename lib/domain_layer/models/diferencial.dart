import '../../data_layer/dtos.dart';

class Diferencial {
  final String id;
  final String idEmprego;
  final int weekday;
  final int percentage;

  Diferencial({
    required this.id,
    required this.idEmprego,
    required this.weekday,
    required this.percentage,
  });

  factory Diferencial.fromDTO(DiferenciaisDTO dto) {
    return Diferencial(
      id: dto.id,
      idEmprego: dto.idEmprego,
      weekday: dto.weekday,
      percentage: dto.percentage,
    );
  }

  DiferenciaisDTO toDTO() {
    return DiferenciaisDTO(
      id: id,
      idEmprego: idEmprego,
      weekday: weekday,
      percentage: percentage,
    );
  }
}