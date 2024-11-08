import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/data_layer/dtos.dart';
import 'package:marcahoras3/data_layer/providers.dart';
import 'package:marcahoras3/data_layer/tables/realm_models.dart';
import 'package:realm/realm.dart';

void main() {
  final String empregoId = "6bce5397-19a3-4d8f-905f-56ae4990d23c";

  final dto = SalariosDto(
    id: Uuid.v4().toString(),
    empregoId: empregoId,
    vigencia: "2024-10",
    valor: 1300.00,
    ativo: true,
  );

  final updatedDto = SalariosDto(
    id: "7e302577-2547-4021-8a14-0370cf8024a5",
    empregoId: empregoId,
    vigencia: "2024-10",
    valor: 1670.00,
    ativo: true,
  );

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

  test('should read salarios', () async {
    final realm = _buildRealm();

    final salariosProvider = SalariosDbProvider(realm: realm);

    final result = await salariosProvider.list(empregoId);

    print(result);
  });

  test('should create salarios', () async {
    final realm = _buildRealm();

    final salariosProvider = SalariosDbProvider(realm: realm);

    final result = await salariosProvider.create(dto);

    assert(result.id != null);
    assert(result.empregoId != null);
    assert(result.empregoId == dto.empregoId);
  });

  test('should update salario', () async {
    final realm = _buildRealm();
    final salariosProvider = SalariosDbProvider(realm: realm);
    final result = await salariosProvider.update(updatedDto);

    assert(result.id != null);
    assert(result.empregoId != null);
    assert(result.empregoId == dto.empregoId);
  });
}
