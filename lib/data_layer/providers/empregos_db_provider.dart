import 'package:marcahoras3/data_layer/mappers/salarios_mapper.dart';
import 'package:marcahoras3/data_layer/tables/realm_models.dart';
import 'package:marcahoras3/utils/utils.dart';
import 'package:realm/realm.dart';

import '../../domain_layer/contracts.dart';
import '../dtos/empregos_dto.dart';
import '../mappers/emprego_mapper.dart';

class EmpregosDbProvider implements EmpregosProviderContract {
  final Realm _realm;

  const EmpregosDbProvider({required Realm realm}) : _realm = realm;

  @override
  Future<EmpregosDto> append(EmpregosDto e) async {
    final emprego = await _realm.writeAsync<EmpregosRealm>(
      () {
        return _realm.add(e.toRealm());
      },
    );

    return emprego.toDto();
  }

  @override
  Future<void> delete(String empregoId) async {
    final emprego = _realm.find<EmpregosRealm>(empregoId);
    if (emprego != null) {
      return _realm.writeAsync(() {
        _realm.delete<EmpregosRealm>(emprego);
      });
    }
  }

  @override
  Future<List<EmpregosDto>> list(String from, String to) async {
    final empregos = _realm.all<EmpregosRealm>();
    return empregos.map((e) => e.toDto(true)).toList();
  }

  @override
  Future<EmpregosDto> update(EmpregosDto emprego) async {
    final e = _realm.find<EmpregosRealm>(emprego.id);
    if (e != null) {
      await _realm.writeAsync(() {
        e.updateFromDto(emprego);
      });

      return emprego;
    }

    throw ResourceNotFound("resource not found");
  }
}
