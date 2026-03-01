import '../../../utils.dart';
import '../../contracts.dart';
import '../../database/db_connector_drift.dart';
import '../../dtos/salarios_dto.dart';
import '../../mappers.dart';

class SalariosProvider implements SalariosProviderContract {
  final AppDatabase _db;

  $$DbSalariosTableTableManager get _table => _db.managers.dbSalarios;

  const SalariosProvider({required AppDatabase db}) : _db = db;

  @override
  Future<SalariosDto> create(SalariosDto salario) async {
    final newId = generateId();
    await _table.create(
      (s) => salario.toCompanion(newId: newId),
    );
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

  @override
  Future<List<SalariosDto>> insertMany(List<SalariosDto> salarios) async {
    await _db.batch((batch) {
      batch.insertAll(_db.dbSalarios, salarios.map((s) => s.toCompanion()));
    });

    return salarios;
  }

  @override
  Future<void> deleteMany(String empregoId) async {
    await _table.filter((s) => s.empregoId.id.equals(empregoId)).delete();
  }
}
