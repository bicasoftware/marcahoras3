import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/data_layer/dtos.dart';
import 'package:marcahoras3/data_layer/providers.dart';
import 'package:marcahoras3/data_layer/tables/realm_models.dart';
import 'package:marcahoras3/utils/date_utils.dart';
import 'package:realm/realm.dart';

void main() {
  Realm _buildRealm() {
    final config = Configuration.local(
      [
        SalariosRealm.schema,
        HorasRealm.schema,
        EmpregosRealm.schema,
      ],
      schemaVersion: 2,
    );

    return Realm(config);
  }

  test('should read from realm', () async {
    final realm = _buildRealm();
    final provider = EmpregosDbProvider(realm: realm);

    final (from, to) = getFormatedDateRange(2024, 10);

    final result = await provider.list(from, to);
    print(result);
  });

  test('should insert a new emprego', () async {
    final realm = _buildRealm();
    final provider = EmpregosDbProvider(realm: realm);

    final result = await provider.append(
      EmpregosDto(
        admissao: formatDate(DateTime.now(), true),
        ativo: true,
        bancoHoras: false,
        cargaHoraria: 220,
        descricao: "Analista de Sistemas",
        entrada: "17:00",
        saida: "20:00",
        porcFeriado: 100,
        porcNormal: 55,
        salarios: [
          SalariosDto(vigencia: "2024-11", valor: 1300.55, ativo: true),
        ],
      ),
    );

    assert(result.id != null);
  });

  test('should update a emprego', () async {
    final realm = _buildRealm();
    final provider = EmpregosDbProvider(realm: realm);

    final dto = EmpregosDto(
      id: "6bce5397-19a3-4d8f-905f-56ae4990d23c",
      admissao: formatDate(DateTime.now(), true),
      ativo: true,
      bancoHoras: false,
      cargaHoraria: 220,
      descricao: "Analista de Sistemas",
      entrada: "17:00",
      saida: "21:00",
      porcFeriado: 100,
      porcNormal: 50,
    );

    final result = await provider.update(dto);

    print(result);
  });

  test('should delete empregos', () async {
    final realm = _buildRealm();
    final provider = EmpregosDbProvider(realm: realm);

    final result =
        await provider.delete("7fc0d5c6-3a6e-4bb2-9609-18733bcf30a1");
  });
}
