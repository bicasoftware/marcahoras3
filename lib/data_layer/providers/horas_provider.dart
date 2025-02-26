import '../../domain_layer/contracts.dart';
import '../dtos.dart';
import '../web.dart';

class HorasProvider implements HorasProviderContract {
  final WebConnector _connector;
  final String _route = EndPoints.horas;

  HorasProvider({
    required WebConnector connector,
  }) : _connector = connector;

  @override
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

  @override
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

  @override
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

  @override
  Future<bool> delete(String horaId) async {
    final result = await _connector.request(
      "$_route/$horaId",
      method: WebMethod.delete,
    );

    return result.data;
  }
}
