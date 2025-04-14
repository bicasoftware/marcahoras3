import 'package:marcahoras3/data_layer/mappers/hora_fixo_mapper.dart';
import 'package:marcahoras3/domain_layer/contracts.dart';
import 'package:sane_uuid/uuid.dart';

import '../../database/db_connector_drift.dart';
import '../../dtos.dart';

class HoraFixoProvider extends HoraFixoProviderContract {
  final AppDatabase _db;
  $$DbHoraFixoTableTableManager get _table => _db.managers.dbHoraFixo;

  HoraFixoProvider({required AppDatabase db}) : _db = db;

  @override
  Future<HoraFixoDTO> insertHoraFixo(HoraFixoDTO horaFixo) async {
    final newId = Uuid.v4().toString();

    await _db.into(_db.dbHoraFixo).insert(horaFixo.toCompanion(newId: newId));

    return horaFixo.copyWith(id: newId);
  }

  @override
  Future<HoraFixoDTO> updateHoraFixo(HoraFixoDTO horaFixo) async {
    await _table
        .filter((f) => f.id.equals(horaFixo.id))
        .update((f) => horaFixo.toCompanion());

    return horaFixo;
  }

  @override
  Future<bool> deleteHoraFixo(String id) async {
    final i = await _table.filter((f) => f.id(id)).delete();
    return i > 0;
  }
}
