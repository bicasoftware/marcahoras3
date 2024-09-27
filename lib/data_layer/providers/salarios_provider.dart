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

    return response.isSuccess
        ? SalariosDto.fromJsonList(response.data)
        : throw response.toWebException();
  }

  Future<SalariosDto> create(SalariosDto salario) async {
    final response = await _connector.request(
      EndPoints.salarios,
      method: WebMethod.post,
      data: salario,
    );

    return response.isSuccess
        ? SalariosDto.fromJson(response.data)
        : throw response.toWebException();
  }

  Future<SalariosDto> update(SalariosDto salario) async {
    final response = await _connector.request(
      EndPoints.salarios,
      method: WebMethod.patch,
      data: salario,
    );

    return response.isSuccess
        ? SalariosDto.fromJson(response.data)
        : throw response.toWebException();
  }

  Future<void> delete(String salarioId) async {
    final response = await _connector.request(
      "${EndPoints.salarios}/$salarioId",
      method: WebMethod.delete,
    );

    if (!response.isSuccess) throw response.toWebException();
  }
}
