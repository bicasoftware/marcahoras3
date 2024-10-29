import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'db_empregos.g.dart';

@DataClassName('empregos')
class EmpregosDb extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get descricao => text()();
  DateTimeColumn get admissao => dateTime().nullable()();
  TextColumn get entrada => text()();
  TextColumn get saida => text()();
  BoolColumn get banco_horas => boolean().withDefault(const Constant(false))();
  IntColumn get porc_normal => integer().withDefault(const Constant(50))();
  IntColumn get porc_feriado => integer().withDefault(const Constant(50))();
  BoolColumn get ativo => boolean().withDefault(const Constant(true))();
  IntColumn get cargaHoraria => integer().withDefault(const Constant(50))();
}

@DataClassName('salarios')
class SalariosDb extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get empregoId => integer().nullable().references(EmpregosDb, #id)();
  TextColumn get vigencia => text()();
  RealColumn get valor => real().withDefault(const Constant(0.0))();
  BoolColumn get ativo => boolean().withDefault(const Constant(true))();
}

@DataClassName('horas')
class HorasDb extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get empregoId => integer().nullable().references(EmpregosDb, #id)();
  DateTimeColumn get admissao => dateTime().nullable()();
  TextColumn get inicio => text()();
  TextColumn get termino => text()();
  TextColumn get tipoHora => text()();
  BoolColumn get ativo => boolean().withDefault(const Constant(true))();
}

@DriftDatabase(tables: [EmpregosDb, SalariosDb, HorasDb])
class HorasDatabase extends _$HorasDatabase {
  HorasDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'horas_db');
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
    );
  }
}
