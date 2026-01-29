import '../../domain_layer/models.dart';
import '../dtos.dart';
import '../mappers.dart';

extension AnosMapper on AnosDto {
  Anos toAno() {
    return Anos(
      ano: this.ano,
      feriados: this.feriados.map((a) => a.toFeriado()).toList(),
    );
  }

  static AnosDto fromJson(Map<String, dynamic> json) {
    return AnosDto(
      ano: json['ano'] as int,
      feriados: FeriadosMapper.fromJsonList(json['feriados']),
    );
  }

  static List<AnosDto> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((a) => fromJson(a)).toList();
  }
}
