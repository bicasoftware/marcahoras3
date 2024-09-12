import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/data_layer/mappers/horas_mapper.dart';
import 'package:marcahoras3/data_layer/providers.dart';
import 'package:marcahoras3/data_layer/repositories/horas_repository.dart';
import 'package:marcahoras3/data_layer/web.dart';
import 'package:marcahoras3/domain_layer/models.dart';
import 'package:marcahoras3/domain_layer/usecases.dart';
import 'package:marcahoras3/utils/utils.dart';

void main() {
  final String fakeToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyYmRlNzA0ZC1jYjk5LTQxYzItOWU3ZC02ZGMyZTQ4ZWNlNWUiLCJyZWZyZXNoX3Rva2VuIjoiIiwiaWF0IjoxNzI1Mjk2NTQ2LCJleHAiOjE3MjU1OTg5NDZ9.rUbYGNMLlzYcj4gAS5cNFR-HQp-pWer1K7u1iWJ1zdg";

  final String empregoId = "ec0a58a3-4069-481e-92eb-c84a8a9dd20e";
  // final String empregoId = "35c727cc-7370-4033-b7ba-994ea7ca9deb";

  final connector = WebConnector("http://localhost:3000");
  connector.addInterceptor(InvalidUserInterceptor());
  final v = Vault();
  v.setVaultData(token: fakeToken, refreshToken: '');

  final hora = Horas(
    bancoHoras: false,
    data: DateTime.now(),
    empregoId: empregoId,
    inicio: "18:00",
    termino: "19:00",
    tipoHora: HorasType.normal,
  );

  test('should list horas or be empty', () {});

  test('should insert from provider', () async {
    final provider = HorasProvider(connector: connector);
    final result = await provider.create(hora.toHorasDto());

    assert(result.id != '');
  });

  test('should insert from repository', () async {
    final provider = HorasProvider(connector: connector);
    final repository = HorasRepository(provider: provider);

    final result = await repository.create(hora);

    assert(result.id != '');
  });
  test('should insert from repository', () async {
    final provider = HorasProvider(connector: connector);
    final repository = HorasRepository(provider: provider);
    final usecase = HorasCreateUseCase(repo: repository);

    final result = await usecase(hora);

    assert(result.id != '');
  });
}
