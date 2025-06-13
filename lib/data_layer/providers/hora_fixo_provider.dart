import 'package:marcahoras3/data_layer/dtos/hora_fixo_dto.dart';
import 'package:marcahoras3/domain_layer/contracts.dart';

import '../web/web.dart';

class HoraFixoProvider implements HoraFixoProviderContract {
  final WebConnector _connector;
  final String _route = EndPoints.horafixo;

  HoraFixoProvider(WebConnector connector) : _connector = connector;

  @override
  Future<bool> deleteHoraFixo(String id) async {
    final result = await _connector.request(
      "$_route/$id",
      method: WebMethod.delete,
    );

    return result.data;
  }

  @override
  Future<HoraFixoDto> insertHoraFixo(HoraFixoDto horaFixo) async {
    return await _upsert(horaFixo, true);
  }

  @override
  Future<HoraFixoDto> updateHoraFixo(HoraFixoDto horaFixo) async {
    return await _upsert(horaFixo, false);
  }

  Future<HoraFixoDto> _upsert(
    HoraFixoDto horafixo,
    bool isInsert,
  ) async {
    final res = await _connector.request(
      _route,
      method: isInsert ? WebMethod.post : WebMethod.patch,
      data: horafixo.toJson(),
    );

    return res.isSuccess
        ? HoraFixoDto.fromJson(res.data)
        : throw res.toWebException();
  }
}
