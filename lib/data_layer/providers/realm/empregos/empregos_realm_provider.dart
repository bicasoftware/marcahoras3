import 'package:realm/realm.dart';

import '../../../dtos.dart';
import '../../../mappers/emprego_mapper.dart';
import '../../../realm_models.dart';

class EmpregosRealmProvider {
  final Realm _realm;

  EmpregosRealmProvider({
    required Realm realm,
  }) : _realm = realm;

  Future<EmpregosDto> create(EmpregosDto emprego) async {
    final newEmprego = await _realm.add<EmpregosRealm>(emprego.toRealmModel());
    return newEmprego.toEmpregosDto();
  }
}
