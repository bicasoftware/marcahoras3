import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/data_layer/dtos.dart';
import 'package:marcahoras3/data_layer/mappers/salarios_mapper.dart';
import 'package:marcahoras3/data_layer/providers.dart';
import 'package:marcahoras3/data_layer/repositories/salarios_repository.dart';
import 'package:marcahoras3/data_layer/web.dart';
import 'package:marcahoras3/domain_layer/usecases.dart';
import 'package:marcahoras3/utils/utils.dart';

void main() {
  final String fakeToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyYmRlNzA0ZC1jYjk5LTQxYzItOWU3ZC02ZGMyZTQ4ZWNlNWUiLCJyZWZyZXNoX3Rva2VuIjoiIiwiaWF0IjoxNzI1Mjk2NTQ2LCJleHAiOjE3MjU1OTg5NDZ9.rUbYGNMLlzYcj4gAS5cNFR-HQp-pWer1K7u1iWJ1zdg";

  final String empregoId = "ec0a58a3-4069-481e-92eb-c84a8a9dd20e";

  final connector = WebConnector("http://localhost:3000");
  connector.addInterceptor(InvalidUserInterceptor());
  final v = Vault();
  v.setVaultData(token: fakeToken, refreshToken: '');

  final salarioDto = SalariosDto(
    ativo: true,
    empregoId: empregoId,
    valor: 1200.00,
    vigencia: "2020-01",
  );

  final salario = salarioDto.toSalario();

  test('should list Salarios', () async {
    try {
      final provider = SalariosProvider(connector: connector);
      final result = await provider.list(empregoId);

      assert(result.length >= 1);
      result.forEach((e) => print(e));

      // assert(result.id != '');
    } catch (e) {
      print(e);
    }
  });

  test('should insert Salario from provider', () async {
    try {
      final provider = SalariosProvider(connector: connector);

      final result = await provider.create(salarioDto);

      assert(result.id != '');
    } catch (e) {
      print(e);
    }
  });

  test('should insert Salario from repo', () async {
    try {
      final provider = SalariosProvider(connector: connector);
      final repository = SalariosRepository(provider: provider);

      final result = await repository.create(salario);

      assert(result.id != '');
    } catch (e) {
      print(e);
    }
  });

  test('should insert Salario from usecase', () async {
    try {
      final provider = SalariosProvider(connector: connector);
      final repository = SalariosRepository(provider: provider);
      final usecase = SalarioCreateUseCase(repository);

      final result = await usecase(salario);

      assert(result.id != '');
    } catch (e) {
      print(e);
    }
  });
}
