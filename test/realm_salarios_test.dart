import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/data_layer/dtos.dart';
import 'package:marcahoras3/data_layer/providers.dart';
import 'package:marcahoras3/data_layer/tables/realm_models.dart';
import 'package:realm/realm.dart';

void main() {
  final String empregoId = "9aded73b-8db5-44cb-b451-f15ffac1e7c2";

  final dto = SalariosDto(
    id: Uuid.v4().toString(),
    empregoId: empregoId,
    vigencia: "2024-01",
    valor: 1300.00,
    ativo: true,
  );

  final updatedDto = SalariosDto(
    id: "eee7d004-ee4c-4500-8acb-07d042d70682",
    empregoId: empregoId,
    vigencia: "2024-12",
    valor: 2000.00,
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

  final realm = _buildRealm();
  final salariosProvider = SalariosDbProvider(realm: realm);

  test('should read salarios', () async {
    final result = await salariosProvider.list(empregoId);
    print(result);
  });

  test('should create salarios', () async {
    final result = await salariosProvider.create(dto);
    print(result);
  });

  test('should update salario', () async {
    final result = await salariosProvider.update(updatedDto);

    print(result);
  });

  test('delete salarios', () async {
    await salariosProvider.delete("5d36d041-30ad-4ae0-82ad-bc5abbbe579e");
  });
}
