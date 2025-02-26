import 'package:sane_uuid/uuid.dart';

import '../../../domain_layer/contracts.dart';
import '../../database/db_connector_drift.dart';
import '../../dtos/salarios_dto.dart';
import '../../mappers.dart';

class SalariosSqlProvider implements SalariosProviderContract {
  final AppDatabase _db;

  $$DbSalariosTableTableManager get _table => _db.managers.dbSalarios;

  const SalariosSqlProvider({required AppDatabase db}) : _db = db;

  @override
  Future<SalariosDto> create(SalariosDto salario) async {
    final newId = Uuid.v4().toString();

    await _table.create((s) => salario.toCompanion(newId: newId));
    return salario.copyWith(id: newId);
  }

  @override
  Future<void> delete(String salarioId) async {
    await _table.filter((s) => s.id.equals(salarioId)).delete();
  }

  @override
  Future<SalariosDto> update(SalariosDto salario) async {
    await _table
        .filter((s) => s.id.equals(salario.id))
        .update((s) => salario.toCompanion());

    return salario;
  }
}
