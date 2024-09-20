import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/data_layer/providers.dart';
import 'package:marcahoras3/data_layer/respositories.dart';
import 'package:marcahoras3/data_layer/web.dart';
import 'package:marcahoras3/domain_layer/usecases.dart';
import 'package:marcahoras3/utils/utils.dart';

void main() {
  final String fakeToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyYmRlNzA0ZC1jYjk5LTQxYzItOWU3ZC02ZGMyZTQ4ZWNlNWUiLCJyZWZyZXNoX3Rva2VuIjoiIiwiaWF0IjoxNzI2NjYyMDc1LCJleHAiOjE3MjY5NjQ0NzV9.CAnNFbzNAJk3t13_Ax73IwZcJVz26N_cOssJEg221D4";

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
  test('should list from usecase empregos', () async {
    try {
      final provider = EmpregosProvider(connector);
      final repo = EmpregoRepository(provider);
      final usecase = await EmpregoDataLoadUseCase(repo);
      
      final result = await usecase();
      
      result.forEach((e) {
        print(e.horas);
        print(e.salarios);
      });
    } catch (e) {
      print("error $e");
    }
  });
}
