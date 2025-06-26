import '../../../data_layer/database/db_connector_drift.dart';
import '../../../data_layer/dtos.dart';
import '../../../data_layer/mappers.dart';

class DbSyncUsecase {
  final AppDatabase _db;

  $$DbEmpregosTableTableManager get _empregosDb => _db.managers.dbEmpregos;
  $$DbHorasTableTableManager get _horasDb => _db.managers.dbHoras;
  $$DbSalariosTableTableManager get _salariosDb => _db.managers.dbSalarios;
  $$DbHoraFixoTableTableManager get _horaFixoDb => _db.managers.dbHoraFixo;
  $$DbDiferenciaisTableTableManager get _diffDb => _db.managers.dbDiferenciais;

  DbSyncUsecase({required AppDatabase db}) : _db = db;

  Future<void> call(List<EmpregosDto> empregos) async {
    /// First, clear the local database
    await _db.transaction(() async {
      await _diffDb.delete();
      await _horaFixoDb.delete();
      await _horasDb.delete();
      await _salariosDb.delete();
      await _empregosDb.delete();
    });

    /// Then, insert all the new data
    return await _db.transaction(() async {
      for (final e in empregos) {
        final now = DateTime.now();
        await _empregosDb.create(
          (_) => e.toCompanion(createdAt: now),
        );

        await _db.batch((batch) {
          batch.insertAll(
            _db.dbHoras,
            e.horas.map((d) => d.toCompanion(createdAt: now)),
          );
        });

        await _db.batch((batch) {
          batch.insertAll(
            _db.dbSalarios,
            e.salarios.map((s) => s.toCompanion(createdAt: now)),
          );
        });

        await _db.batch((batch) {
          batch.insertAll(
            _db.dbDiferenciais,
            e.diferenciaisList.map(
              (e) => e.toCompanion(),
            ),
          );
        });

        await _db.batch((batch) {
          batch.insertAll(
            _db.dbHoraFixo,
            e.horaFixoList.map(
              (e) => e.toCompanion(),
            ),
          );
        });
      }
    });
  }
}
