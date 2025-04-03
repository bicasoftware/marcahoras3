import 'package:drift/drift.dart';
import 'package:marcahoras3/utils/date_utils.dart';
import 'package:sane_uuid/uuid.dart';

import '../../../domain_layer/contracts.dart';
import '../../database/db_connector_drift.dart';
import '../../dtos.dart';
import '../../mappers.dart';

class EmpregosSqlProvider implements EmpregosProviderContract {
  final AppDatabase _db;

  $$DbEmpregosTableTableManager get _table => _db.managers.dbEmpregos;
  $$DbHorasTableTableManager get _tableHoras => _db.managers.dbHoras;
  $$DbSalariosTableTableManager get _tableSalarios => _db.managers.dbSalarios;

  const EmpregosSqlProvider({required AppDatabase db}) : _db = db;

  @override
  Future<EmpregosDto> create(EmpregosDto e) async {
    final newId = Uuid.v4().toString();
    final createdAt = DateTime.now();
    await _table.create(
      (it) => e.toCompanion(newId: newId, createdAt: createdAt),
    );
    return e.copyWith(id: newId);
  }

  @override
  Future<void> delete(String empregoId) async {
    await _tableHoras.filter((h) => h.empregoId.id.equals(empregoId)).delete();

    await _tableSalarios
        .filter((s) => s.empregoId.id.equals(empregoId))
        .delete();

    await _table.filter((e) => e.id.equals(empregoId)).delete();
  }

  @override
  Future<List<EmpregosDto>> list(String from, String to) async {
    final empregos = await _table.get();
    final empregosDtoList = <EmpregosDto>[];

    final horas =
        await _tableHoras
            .filter((h) => h.data.isBetween(parseDate(from)!, parseDate(to)!))
            .get();

    final horasDto = horas.map((h) => HorasDto.fromJson(h.toJson())).toList();

    final salarios = await _tableSalarios.get();
    final salariosDto =
        salarios.map((s) => SalariosDto.fromJson(s.toJson())).toList();

    empregos.forEach((e) {
      final empregoDto = EmpregosDto.fromJson(e.toJson());
      empregosDtoList.add(
        empregoDto.copyWith(
          horas: horasDto.where((h) => h.empregoId == e.id).toList(),
          salarios: salariosDto.where((s) => s.empregoId == e.id).toList(),
        ),
      );
    });

    return empregosDtoList;
  }

  @override
  Future<EmpregosDto> update(EmpregosDto emprego) async {
    final createdAt = DateTime.now();
    await _table
        .filter((e) => e.id.equals(emprego.id))
        .update((_) => emprego.toCompanion(createdAt: createdAt));

    return emprego;
  }
}
