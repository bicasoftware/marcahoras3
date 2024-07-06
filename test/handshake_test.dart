import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/data_layer/dtos.dart';
import 'package:marcahoras3/data_layer/web/web.dart';

void main() {
  final connector = WebConnector("http://localhost:3000");

  test('should get a handshake response', () async {
    final response = await connector.request(
      EndPoints.handshake,
      method: WebMethod.get,
    );

    assert((response.data?['status'] as String) == 'ok');
    assert(response.statusCode == 200);
  });

  test(
    'should Login and return a token',
    () async {
      final response = await connector.request(
        EndPoints.login,
        method: WebMethod.post,
        authHeader: null,
        data: {"email": "test@test.com", "password": "123456"},
      );

      final validRequest = [200, 201].contains(response.statusCode);
      assert(validRequest);
      assert(response.data != null);
      assert(response.data.toString().isNotEmpty);

      if (validRequest) {
        final tokenData = AuthenticationDataDto.fromJson(response.data);

        assert(tokenData.accessToken.isNotEmpty);
        assert(tokenData.refreshToken.isEmpty);
      } else {
        throw Exception(
          "Invalid Status Code - ${response.statusCode} - with ${response.data}",
        );
      }
    },
  );
}
