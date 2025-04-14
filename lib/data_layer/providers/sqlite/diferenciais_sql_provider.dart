import 'package:marcahoras3/data_layer/mappers/diferenciais_mapper.dart';
import 'package:sane_uuid/uuid.dart';

import '../../../domain_layer/contracts.dart';
import '../../database/db_connector_drift.dart';
import '../../dtos.dart';

class DiferenciaisSqlProvider extends DiferenciaisProviderContract {
  final AppDatabase _db;
  $$DbDiferenciaisTableTableManager get _table => _db.managers.dbDiferenciais;

  DiferenciaisSqlProvider({required AppDatabase db}) : _db = db;

  @override
  Future<DiferenciaisDTO> insertDiferencial(DiferenciaisDTO diferencial) async {
    final id = Uuid.v4().toString();
    await _db
        .into(_db.dbDiferenciais)
        .insert(diferencial.toCompanion(newId: id));

    return diferencial.copyWith(id: id);
  }

  @override
  Future<DiferenciaisDTO> updateDiferencial(DiferenciaisDTO diferencial) async {
    await _table
        .filter((d) => d.id.equals(diferencial.id))
        .update((f) => diferencial.toCompanion());

    return diferencial;
  }

  Future<bool> deleteDiferencial(String id) async {
    final changedRows = await _table.filter((f) => f.id(id)).delete();
    return changedRows > 0;
  }
}
