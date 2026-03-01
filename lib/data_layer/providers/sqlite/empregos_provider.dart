import 'package:drift/drift.dart';

import '../../../utils.dart';
import '../../contracts.dart';
import '../../database/db_connector_drift.dart';
import '../../dtos.dart';
import '../../mappers.dart';

class EmpregosProvider implements EmpregosProviderContract {
  final AppDatabase _db;

  $$DbEmpregosTableTableManager get _table => _db.managers.dbEmpregos;
  $$DbHorasTableTableManager get _tableHoras => _db.managers.dbHoras;
  $$DbSalariosTableTableManager get _tableSalarios => _db.managers.dbSalarios;

  const EmpregosProvider({required AppDatabase db}) : _db = db;

  @override
  Future<EmpregosDto> create(EmpregosDto e) async {
    await _table.create(
      (it) => e.toCompanion(),
    );
    return e;
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
  Future<EmpregosDto> update(EmpregosDto emprego) async {
    await _table
        .filter((e) => e.id.equals(emprego.id))
        .update((_) => emprego.toCompanion());

    return emprego;
  }

  @override
  Future<List<EmpregosDto>> listByVigencia({
    required int year,
    required int month,
  }) async {
    final empregos = await _table
        .withReferences(
          (prefetch) => prefetch(
            dbHorasRefs: false,
            dbSalariosRefs: true,
            dbDiferenciaisRefs: true,
          ),
        )
        .get();
    final empregosList = <EmpregosDto>[];

    for (final e in empregos) {
      final (from, to) = getFormatedDateRangeByFechamento(
        year,
        month,
        e.$1.diaFechamento,
      );

      final results = await Future.wait([
        e.$2.dbSalariosRefs.get(),
        e.$2.dbDiferenciaisRefs.get(),
        _tableHoras
            .filter((h) => h.empregoId.id.equals(e.$1.id))
            .filter((h) => h.data.isBetween(parseDate(from)!, parseDate(to)!))
            .get(),
      ]);

      final empregoDto = EmpregoMapper.fromJson(
        e.$1.toJson(),
        salarios: results[0].map((s) => s.toJson()).toList(),
        diferenciais: results[1].map((d) => d.toJson()).toList(),
        horas: results[2].map((e) => e.toJson()),
      );

      empregosList.add(
        empregoDto,
      );
    }

    return empregosList;
  }
}
