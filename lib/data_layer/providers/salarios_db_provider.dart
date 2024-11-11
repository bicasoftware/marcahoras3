import 'package:marcahoras3/data_layer/mappers/salarios_mapper.dart';
import 'package:marcahoras3/utils/utils.dart';
import 'package:realm/realm.dart';

import '../../domain_layer/contracts.dart';
import '../dtos/salarios_dto.dart';
import '../tables/realm_models.dart';

class SalariosDbProvider implements SalariosProviderContract {
  final Realm _realm;

  SalariosDbProvider({required Realm realm}) : _realm = realm;

  @override
  Future<SalariosDto> create(SalariosDto salario) async {
    final emprego = _realm.find<EmpregosRealm>(salario.empregoId);

    if (emprego != null) {
      await _realm.writeAsync(
        () => emprego.salarios.add(salario.toRealm()),
      );

      return salario;
    }

    throw ResourceNotFound('resource not found');
  }

  @override
  Future<void> delete(String salarioId) async {
    final s = _realm.find<SalariosRealm>(salarioId);
    if (s != null) {
      await _realm.writeAsync(() => _realm.delete(s));
    }
  }

  @override
  Future<List<SalariosDto>> list(String empregoId) async {
    final result = _realm.find<EmpregosRealm>(empregoId);
    if (result != null) {
      return result.salarios
          .where((s) => s.empregoId != null)
          .map((s) => s.toDto())
          .toList();
    }

    return [];
  }

  @override
  Future<SalariosDto> update(SalariosDto salario) async {
    final s = _realm.find<SalariosRealm>(salario.id);
    if (s != null) {
      await _realm.writeAsync(() {
        s.updateFromDto(salario);
      });

      return salario;
    }

    throw ResourceNotFound('resource not found');
  }
}
