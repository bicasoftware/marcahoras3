import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/data_layer/dtos.dart';
import 'package:marcahoras3/data_layer/providers.dart';
import 'package:marcahoras3/data_layer/tables/realm_models.dart';
import 'package:marcahoras3/utils/date_utils.dart';
import 'package:realm/realm.dart';

void main() {
  final String empregoId = "9aded73b-8db5-44cb-b451-f15ffac1e7c2";

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
  final horasProvider = HorasDbProvider(realm: realm);

  final dto = HorasDto(
    id: Uuid.v4().toString(),
    empregoId: empregoId,
    bancoHoras: false,
    data: DateTime.now(),
    inicio: "18:00",
    termino: "19:00",
    tipoHora: 'n',
  );

  final updatedDto = HorasDto(
    id: "33bda68c-6048-4adf-ab22-9b98d548c5d2",
    empregoId: empregoId,
    bancoHoras: false,
    inicio: "17:00",
    termino: "21:00",
    tipoHora: 'n',
  );

  test('should read horas', () async {
    final (from, to) = getFormatedDateRange(2024, 11);

    final result = await horasProvider.list(empregoId, from, to);

    print(result);
  });

  test('should create hora', () async {
    final result = await horasProvider.create(dto);
    assert(result.id == dto.id);
  });

  test('should update hora', () async {
    final result = await horasProvider.update(updatedDto);
    assert(result.id == updatedDto.id);
  });

  test('should delete hora', () async {
    final result =
        await horasProvider.delete("704a3f72-fbb3-4568-a4ba-63330b39dbab");

    assert(result == true);
  });
}
