import 'package:marcahoras3/data_layer/web/web_exception.dart';
import 'package:realm/realm.dart';

import 'endpoints.dart';
import 'web_connector.dart';
import 'web_methods.dart';

Future<T> fetchData<T>({
  required Realm realm,
  required WebConnector connector,
  required T Function(WebConnector connector) onIsConnected,
  required T Function(Realm realm) onConnectionFailed,
}) async {
  try {
    final response = await connector.request(
      EndPoints.handshake,
      method: WebMethod.get,
      skipAuth: true,
    );

    if (response.isSuccess && response.data?['status'] == 'ok') {
      return onIsConnected(connector);
    }

    return onConnectionFailed(realm);
  } catch (e) {
    return onConnectionFailed(realm);
  }
}

Future<T> sendData<T>({
  required Realm realm,
  required WebConnector connector,
  required Future<T> Function(WebConnector connector) onIsConnected,
  required T Function(Realm realm, T serverResult) setRealmData,
}) async {
  try {
    final response = await connector.request(
      EndPoints.handshake,
      method: WebMethod.get,
    );

    if (response.isSuccess && response.data?['status'] == 'ok') {
      final result = await onIsConnected(connector);
      return setRealmData(realm, result);
    }

    throw WebException(
      errorMessage: 'ERR_NO_INTERNET',
      statusCode: 900,
      errorDetail: 'ERR_CANT_ADD_OFFLINE_DATA',
    );
  } catch (e) {
    rethrow;
  }
}
