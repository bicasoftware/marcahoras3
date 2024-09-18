import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/data_layer/dtos.dart';
import 'package:marcahoras3/data_layer/mappers/emprego_mapper.dart';
import 'package:marcahoras3/data_layer/providers.dart';
import 'package:marcahoras3/data_layer/respositories.dart';
import 'package:marcahoras3/data_layer/web.dart';
import 'package:marcahoras3/domain_layer/usecases.dart';
import 'package:marcahoras3/utils/vault/vault.dart';

void main() {
  final String fakeToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJmZmY5NTI1OC1jODNiLTQ3NDUtYWJjMi04YWVkOTQxNGIxMzEiLCJyZWZyZXNoX3Rva2VuIjoiIiwiaWF0IjoxNzI2NjY0Mjg1LCJleHAiOjE3MjY5NjY2ODV9.-z1f5TGJy69zPmKEmCzU4RHLq9zV6ihu4Kdjq54DGnM";

  final connector = WebConnector("http://localhost:3000");
  connector.addInterceptor(InvalidUserInterceptor());
  final v = Vault();
  v.setVaultData(token: fakeToken, refreshToken: '');

  final empregoDto = EmpregosDto(
    admissao: "2020-01-01",
    ativo: true,
    descricao: "Analista",
    bancoHoras: false,
    cargaHoraria: 220,
    entrada: "08:00",
    saida: "18:00",
    porcFeriado: 100,
    porcNormal: 50,
  );

  final empregoModel = empregoDto.toEmprego();

  test('should insert data via EmpregosProvider', () async {
    try {
      final provider = EmpregosProvider(connector);
      final result = await provider.append(empregoDto);
      assert(result.id != '');
    } catch (e) {
      print("error $e");
    }
  });

  test('should insert data via Repository', () async {
    final provider = EmpregosProvider(connector);
    final repo = EmpregoRepository(provider);

    final result = await repo.append(empregoModel);

    assert(result.id != '');
  });

  test('should insert data via useCase', () async {
    final provider = EmpregosProvider(connector);
    final repo = EmpregoRepository(provider);
    final useCase = EmpregoInsertUseCase(repo);
    final result = await useCase(empregoModel);

    assert(result.id != '');
  });
}
