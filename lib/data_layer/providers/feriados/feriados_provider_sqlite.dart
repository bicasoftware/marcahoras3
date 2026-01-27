import 'package:drift/drift.dart';

import '../../contracts.dart';
import '../../database/db_connector_drift.dart';
import '../../dtos.dart';
import '../../mappers.dart';

class FeriadosProviderSqlite implements FeriadosContract {
  final AppDatabase _db;

  FeriadosProviderSqlite({required AppDatabase db}) : _db = db;

  $$DbFeriadosTableTableManager get _table => _db.managers.dbFeriados;

  @override
  Future<List<FeriadosDto>> fetchFeriados(int year) async {
    var feriados = await _table
        .filter(
          (it) =>
              it.date.isBetween(DateTime(year, 1, 1), DateTime(year, 12, 31)),
        )
        .get();

    return FeriadosDto.fromJsonList(feriados.map((e) => e.toJson()).toList());
  }

  @override
  Future<List<FeriadosDto>> insertFeriados(
    List<FeriadosDto> feriadosList,
  ) async {
    await _db.batch((batch) {
      batch.insertAll(_db.dbFeriados, feriadosList.map((d) => d.toCompanion()));
    });

    return feriadosList;
  }
}
