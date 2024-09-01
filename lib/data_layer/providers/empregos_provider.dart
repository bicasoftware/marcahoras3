import 'package:realm/realm.dart';

import '../dtos.dart';
import '../realm_models.dart';
import '../web.dart';

class EmpregosProvider {
  final Realm _realm;
  final WebConnector _connector;

  const EmpregosProvider({
    required Realm realm,
    required WebConnector connector,
  })  : _realm = realm,
        _connector = connector;

  Future<List<EmpregosDto>> list() async {
    final response = await _connector.request(
      EndPoints.empregos,
      method: WebMethod.get,
    );

    return EmpregosDto.fromJsonList(response.data);
  }

  Future<EmpregosDto> append(EmpregosDto e) async {
    final result = await _connector.request(
      EndPoints.empregos,
      method: WebMethod.post,
      data: e,
    );

    return EmpregosDto.fromJson(result.data);
  }

  Future<void> delete(String empregoId) async {
    assert(empregoId.isNotEmpty);
    await _connector.request(
      EndPoints.empregos,
      queryParams: {
        "id": empregoId,
      },
    );
  }

  Future<void> cleanAll() async {
    _realm.deleteAll<SalariosRealm>();
    _realm.deleteAll<HorasRealm>();
    _realm.deleteAll<EmpregosRealm>();
  }
}
