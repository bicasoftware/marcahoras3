import 'package:drift/drift.dart';

import '../../../utils.dart';
import '../../contracts.dart';
import '../../database/db_connector_drift.dart';
import '../../dtos/horas_dto.dart';
import '../../mappers.dart';

class HorasProvider implements HorasProviderContract {
  final AppDatabase _db;

  $$DbHorasTableTableManager get _table => _db.managers.dbHoras;

  const HorasProvider({required AppDatabase db}) : _db = db;

  @override
  Future<HorasDto> create(HorasDto hora) async {
    final id = generateId();

    final int h = await _db
        .into(_db.dbHoras)
        .insert(hora.toCompanion(newId: id));
    return hora.copyWithId("$h");
  }

  @override
  Future<bool> delete(String horaId) async {
    final h = await _table.filter((h) => h.id(horaId)).delete();
    return h > 0;
  }

  @override
  Future<List<HorasDto>> list(String empregoId, String from, String to) async {
    final fromDate = parseDate(from);
    final toDate = parseDate(to);
    final horas = await _table
        .filter(
          (h) =>
              h.empregoId.id.equals(empregoId) &
              h.data.isBetween(fromDate!, toDate!),
        )
        .get();

    return horas.map((h) => HorasMapper.fromJson(h.toJson())).toList();
  }

  @override
  Future<HorasDto> update(HorasDto hora) async {
    await _table
        .filter((h) => h.id.equals(hora.id))
        .update((e) => hora.toCompanion());

    return hora;
  }
}
