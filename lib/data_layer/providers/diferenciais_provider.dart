import '../../domain_layer/contracts.dart';
import '../dtos.dart';
import '../web/web.dart';

class DiferenciaisProvider implements DiferenciaisProviderContract {
  final WebConnector _connector;
  final String _route = EndPoints.diferenciais;

  DiferenciaisProvider(WebConnector connector) : _connector = connector;

  @override
  Future<bool> deleteDiferencial(String id) async {
    final result = await _connector.request(
      "$_route",
      method: WebMethod.delete,
      queryParams: {
        "id": id,
      },
    );

    return result.isSuccess ? result.data : throw result.toWebException();
  }

  @override
  Future<DiferenciaisDto> insertDiferencial(DiferenciaisDto diferencial) async {
    return await _upsert(diferencial, true);
  }

  @override
  Future<List<DiferenciaisDto>> insertMany(
    List<DiferenciaisDto> difList,
  ) async {
    final res = await _connector.request(
      "$_route/many",
      method: WebMethod.post,
      data: DiferenciaisDto.toJsonList(difList),
    );

    return res.isSuccess
        ? DiferenciaisDto.fromJsonList(res.data)
        : throw res.toWebException();
  }

  @override
  Future<DiferenciaisDto> updateDiferencial(DiferenciaisDto diferencial) async {
    return await _upsert(diferencial, false);
  }

  Future<DiferenciaisDto> _upsert(
    DiferenciaisDto diferencial,
    bool isInsert,
  ) async {
    final res = await _connector.request(
      _route,
      method: isInsert ? WebMethod.post : WebMethod.patch,
      data: diferencial.toJson(),
    );

    return res.isSuccess
        ? DiferenciaisDto.fromJson(res.data)
        : throw res.toWebException();
  }
}
