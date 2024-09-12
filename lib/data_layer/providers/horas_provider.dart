import '../dtos.dart';
import '../web.dart';

class HorasProvider {
  final WebConnector _connector;
  final String _route = EndPoints.horas;

  HorasProvider({
    required WebConnector connector,
  }) : _connector = connector;

  Future<List<HorasDto>> list(String empregoId) async {
    final result = await _connector.request(
      _route,
      method: WebMethod.get,
      queryParams: {
        "emprego_id": empregoId,
      },
    );

    return HorasDto.fromJsonList(result.data);
  }

  Future<HorasDto> findOne(String horaId) async {
    final result = await _connector.request(
      _route,
      method: WebMethod.get,
      queryParams: {
        "id": horaId,
      },
    );

    return HorasDto.fromJson(result.data);
  }

  Future<HorasDto> create(HorasDto hora) async {
    final result = await _connector.request(
      _route,
      method: WebMethod.post,
      data: hora,
    );

    return HorasDto.fromJson(result.data);
  }

  Future<HorasDto> update(HorasDto hora) async {
    final result = await _connector.request(
      _route,
      method: WebMethod.patch,
      data: hora,
    );

    return HorasDto.fromJson(result.data);
  }

  Future<bool> delete(String horaId) async {
    final result = await _connector.request(
      "$_route/$horaId",
      method: WebMethod.post,
    );

    return result.data;
  }
}
