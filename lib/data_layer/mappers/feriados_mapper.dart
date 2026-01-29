import '../../domain_layer/models.dart';
import '../../utils.dart';
import '../dtos.dart';

extension FeriadosMapper on FeriadosDto {
  Feriados toFeriado() {
    return Feriados(
      data: this.data!,
      nome: this.nome ?? '',
    );
  }

  static FeriadosDto fromJson(Map<String, dynamic> json) {
    return FeriadosDto(
      data: parseDate(json['data']),
      nome: json['nome'],
    );
  }

  static List<FeriadosDto> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => fromJson(json)).toList();
  }
}
