import '../../data_layer/dtos.dart';

class HoraFixo {
  final String id;
  final String idEmprego;
  final double value;
  final String vigencia;

  HoraFixo({
    required this.id,
    required this.idEmprego,
    required this.value,
    required this.vigencia,
  });

  factory HoraFixo.fromDTO(HoraFixoDTO dto) {
    return HoraFixo(
      id: dto.id,
      idEmprego: dto.idEmprego,
      value: dto.value,
      vigencia: dto.vigencia,
    );
  }

  HoraFixoDTO toDTO() {
    return HoraFixoDTO(
      id: id,
      idEmprego: idEmprego,
      value: value,
      vigencia: vigencia,
    );
  }

  HoraFixo copyWith({
    String? id,
    String? idEmprego,
    double? value,
    String? vigencia,
  }) {
    return HoraFixo(
      id: id ?? this.id,
      idEmprego: idEmprego ?? this.idEmprego,
      value: value ?? this.value,
      vigencia: vigencia ?? this.vigencia,
    );
  }
}