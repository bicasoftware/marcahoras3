import '../dtos.dart';
import '../web.dart';

class HorasProvider {
  final WebConnector _connector;
  final String _route = EndPoints.horas;

  HorasProvider({
    required WebConnector connector,
  }) : _connector = connector;

  Future<List<HorasDto>> list(String empregoId, String from, String to) async {
    final result = await _connector.request(
      _route,
      method: WebMethod.get,
      queryParams: {
        "emprego": empregoId,
        "from": from,
        "to": to,
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
      EndPoints.horas,
      method: WebMethod.post,
      data: hora.toJson(),
    );

    return result.isSuccess
        ? HorasDto.fromJson(result.data)
        : throw result.toWebException();
  }

  Future<HorasDto> update(HorasDto hora) async {
    final result = await _connector.request(
      _route,
      method: WebMethod.patch,
      data: hora,
    );

    return result.isSuccess
        ? HorasDto.fromJson(result.data)
        : throw result.toWebException();
  }

  Future<bool> delete(String horaId) async {
    final result = await _connector.request(
      "$_route/$horaId",
      method: WebMethod.post,
    );

    return result.data;
  }
}
