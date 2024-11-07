import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/data_layer/providers.dart';
import 'package:marcahoras3/data_layer/tables/realm_models.dart';
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

  test('deve criar uma instancia do realm', () async {
    final realm = _buildRealm();
    print(realm.hashCode);
  });

  test('passando uma instancia de realm para um provider', () async {
    final realm = _buildRealm();

    final salariosProvider = SalariosDbProvider(realm: realm);
    final horasProvider = HorasDbProvider(realm: realm);
    final empregosProvider = EmpregosDbProvider(realm: realm);

    print(salariosProvider.hashCode);
    print(horasProvider.hashCode);
    print(empregosProvider.hashCode);
  });
}
