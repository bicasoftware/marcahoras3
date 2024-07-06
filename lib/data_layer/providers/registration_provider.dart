import 'package:marcahoras3/data_layer/web/web.dart';

import '../dtos.dart';

class RegistrationProvider {
  final WebConnector _connector;

  const RegistrationProvider({
    required WebConnector connector,
  }) : _connector = connector;

  /// Try to connect to the server
  /// fetch a [AuthenticationDataDto] containing
  /// an accessToken , a refreshToken, and initial userData
  Future<AuthenticationDataDto> login({
    required String email,
    required String password,
  }) async {
    final response = await _connector.request(
      EndPoints.register,
      method: WebMethod.get,
      data: {
        'email': email,
        'password': password,
      },
    );

    return AuthenticationDataDto.fromJson(response.data);
  }

  /// Try to connect to the server
  /// fetch a [AuthenticationDataDto] containing
  /// an accessToken and a refreshToken
  Future<AuthenticationDataDto> register({
    required String email,
    required String password,
  }) async {
    
    final WebResponse response = await _connector.request(
      EndPoints.register,
      method: WebMethod.get,
      data: {
        'email': email,
        'password': password,
      },
    );

    return AuthenticationDataDto.fromJson(response.data);
  }
}
