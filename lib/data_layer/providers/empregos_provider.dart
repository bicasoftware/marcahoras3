import 'package:marcahoras3/data_layer/mappers/emprego_mapper.dart';
import 'package:marcahoras3/data_layer/realm_models/empregos_realm.dart';
import 'package:marcahoras3/data_layer/web/request_helper.dart';
import 'package:marcahoras3/data_layer/web/web.dart';
import 'package:realm/realm.dart';

import '../dtos.dart';

class EmpregosProvider {
  final Realm _realm;
  final WebConnector _connector;

  const EmpregosProvider({
    required Realm realm,
    required WebConnector connector,
  })  : _realm = realm,
        _connector = connector;

  Future<List<EmpregosDto>> list() async {
    return await fetchData<Future<List<EmpregosDto>>>(
      realm: _realm,
      connector: _connector,
      onIsConnected: (WebConnector c) async {
        final response = await c.request(
          EndPoints.empregos,
          method: WebMethod.get,
        );

        if (response.statusCode != 200) {
          throw WebException(
            statusCode: response.statusCode,
            errorMessage: response.statusMessage,
            errorDetail: response.data['message'],
          );
        }

        return EmpregosDto.fromJsonList(response.data);
      },
      onConnectionFailed: (Realm r) async {
        final dbData = r.all<EmpregosRealm>();
        return dbData.map((e) => e.toEmpregosDto()).toList();
      },
    );
  }

  Future<EmpregosDto> append(EmpregosDto e) async {
    return await sendData<EmpregosDto>(
      connector: _connector,
      realm: _realm,
      onIsConnected: (c) async {
        final result = await _connector.request(
          EndPoints.salarios,
          method: WebMethod.post,
          data: e.toJson(),
        );

        return EmpregosDto.fromJson(result.data);
      },
      setRealmData: (realm, result) {
        realm.add<EmpregosRealm>(result.toRealmModel());
        return result;
      },
    );
  }

  Future<void> delete(String empregoId) async {
    assert(empregoId.isNotEmpty);

    return await sendData<void>(
      connector: _connector,
      realm: _realm,
      onIsConnected: (c) async {
        await c.request(
          EndPoints.empregos,
          queryParams: {
            "id": empregoId,
          },
        );
      },
      setRealmData: (realm, _) {
        final realmEmprego = realm.find<EmpregosRealm>(empregoId);
        if (realmEmprego != null) {
          realm.delete<EmpregosRealm>(realmEmprego);
        }
      },
    );
  }
}
