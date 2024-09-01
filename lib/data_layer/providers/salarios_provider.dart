import '../web.dart';
import '../dtos.dart';

class SalariosProvider {
  final WebConnector _connector;

  SalariosProvider({
    required WebConnector connector,
  }) : _connector = connector;

  Future<List<SalariosDto>> list(String empregoId) async {
    final response = await _connector.request(
      EndPoints.salarios,
      method: WebMethod.get,
      queryParams: {
        'emprego_id': empregoId,
      },
    );

    return SalariosDto.fromJsonList(response.data);
  }

  Future<SalariosDto> create(SalariosDto salario) async {
    final response = await _connector.request(
      EndPoints.salarios,
      method: WebMethod.post,
      data: salario,
    );

    return SalariosDto.fromJson(response.data);
  }

  Future<void> delete(String salarioId) async {
    await _connector.request(
      EndPoints.salarios,
      method: WebMethod.delete,
      queryParams: {
        'salario_id': salarioId,
      },
    );
  }
}
