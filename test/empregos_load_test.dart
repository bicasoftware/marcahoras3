import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/data_layer/providers.dart';
import 'package:marcahoras3/data_layer/web.dart';
import 'package:marcahoras3/utils/utils.dart';

void main() {
  final String fakeToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJmZmY5NTI1OC1jODNiLTQ3NDUtYWJjMi04YWVkOTQxNGIxMzEiLCJyZWZyZXNoX3Rva2VuIjoiIiwiaWF0IjoxNzI2NjY0Mjg1LCJleHAiOjE3MjY5NjY2ODV9.-z1f5TGJy69zPmKEmCzU4RHLq9zV6ihu4Kdjq54DGnM";

  final connector = WebConnector("http://localhost:3000");
  connector.addInterceptor(InvalidUserInterceptor());
  final v = Vault();
  v.setVaultData(token: fakeToken, refreshToken: '');

  test('should list empregos', () async {
    try {
      final provider = EmpregosProvider(connector);
      final result = await provider.list();
      result.forEach((e) {
        print(e.horas);
        print(e.salarios);
      });
    } catch (e) {
      print("error $e");
    }
  });
}
