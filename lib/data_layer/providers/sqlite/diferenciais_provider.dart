import 'package:sane_uuid/uuid.dart';

import '../../../domain_layer/contracts.dart';
import '../../database/db_connector_drift.dart';
import '../../dtos.dart';
import '../../mappers/diferenciais_mapper.dart';

class DiferenciaisProvider extends DiferenciaisProviderContract {
  final AppDatabase _db;
  $$DbDiferenciaisTableTableManager get _table => _db.managers.dbDiferenciais;

  DiferenciaisProvider({required AppDatabase db}) : _db = db;

  @override
  Future<DiferenciaisDto> insertDiferencial(DiferenciaisDto diferencial) async {
    final id = Uuid.v4().toString();
    await _db
        .into(_db.dbDiferenciais)
        .insert(diferencial.toCompanion(newId: id));

    return diferencial.copyWith(id: id);
  }

  @override
  Future<DiferenciaisDto> updateDiferencial(DiferenciaisDto diferencial) async {
    await _table
        .filter((d) => d.id.equals(diferencial.id))
        .update((f) => diferencial.toCompanion());

    return diferencial;
  }

  @override
  Future<bool> deleteDiferencial(String id) async {
    final changedRows = await _table.filter((f) => f.id(id)).delete();
    return changedRows > 0;
  }

  @override
  Future<List<DiferenciaisDto>> insertMany(
    List<DiferenciaisDto> difList,
  ) async {
    await _db.batch((batch) {
      batch.insertAll(_db.dbDiferenciais, difList.map((d) => d.toCompanion()));
    });

    return difList;
  }
}
