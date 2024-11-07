import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/data_layer/dtos.dart';
import 'package:marcahoras3/data_layer/providers.dart';
import 'package:marcahoras3/data_layer/tables/realm_models.dart';
import 'package:marcahoras3/utils/date_utils.dart';
import 'package:realm/realm.dart';

void main() {
  Realm _buildRealm() {
    final config = Configuration.local([
      SalariosRealm.schema,
      HorasRealm.schema,
      EmpregosRealm.schema,
    ]);

    return Realm(config);
  }

  final realm = _buildRealm();
  final horasProvider = HorasDbProvider(realm: realm);

  final dto = HorasDto(
    id: Uuid.v4().toString(),
    empregoId: "9aded73b-8db5-44cb-b451-f15ffac1e7c2",
    bancoHoras: false,
    data: DateTime.now(),
    inicio: "18:00",
    termino: "19:00",
    tipoHora: 'n',
  );

  final updatedDto = HorasDto(
    id: "43f9ec2a-6462-466a-9fe9-57022c6854e6",
    bancoHoras: false,
    inicio: "17:00",
    termino: "21:00",
    tipoHora: 'n',
  );

  test('should read horas', () async {
    final (from, to) = getFormatedDateRange(2024, 11);

    final result = await horasProvider.list(
        "9aded73b-8db5-44cb-b451-f15ffac1e7c2", from, to);

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
        await horasProvider.delete("bd8dcefa-cf03-4977-9ee3-48ba7abb7337");

    assert(result == true);
  });
}
