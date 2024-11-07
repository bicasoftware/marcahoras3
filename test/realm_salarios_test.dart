import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/data_layer/dtos.dart';
import 'package:marcahoras3/data_layer/providers.dart';
import 'package:marcahoras3/data_layer/tables/realm_models.dart';
import 'package:realm/realm.dart';

void main() {
  final dto = SalariosDto(
    id: Uuid.v4().toString(),
    empregoId: "9aded73b-8db5-44cb-b451-f15ffac1e7c2",
    vigencia: "2024-10",
    valor: 1300.00,
    ativo: true,
  );

  final updatedDto = SalariosDto(
    id: "7e302577-2547-4021-8a14-0370cf8024a5",
    empregoId: "9aded73b-8db5-44cb-b451-f15ffac1e7c2",
    vigencia: "2024-10",
    valor: 1670.00,
    ativo: true,
  );

  Realm _buildRealm() {
    final config = Configuration.local([
      SalariosRealm.schema,
      HorasRealm.schema,
      EmpregosRealm.schema,
    ]);

    return Realm(config);
  }

  test('should read salarios', () async {
    final realm = _buildRealm();

    final salariosProvider = SalariosDbProvider(realm: realm);

    final result =
        await salariosProvider.list("9aded73b-8db5-44cb-b451-f15ffac1e7c2");

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
