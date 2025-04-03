import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'db_connector_drift.g.dart';

class DbHoras extends Table {
  TextColumn get id => text().unique()();
  @JsonKey('emprego_id')
  TextColumn get empregoId => text().references(DbEmpregos, #id)();
  DateTimeColumn get data => dateTime().nullable()();
  TextColumn get inicio => text().withLength(min: 8, max: 8)();
  TextColumn get termino => text().withLength(min: 8, max: 8)();
  @JsonKey('tipo_hora')
  TextColumn get tipoHora => text().withLength(max: 1)();
  @JsonKey('banco_horas')
  BoolColumn get bancoHoras => boolean()();
  @JsonKey('created_at')
  DateTimeColumn get createdAt => dateTime()();
}

class DbSalarios extends Table {
  TextColumn get id => text().unique()();
  @JsonKey('emprego_id')
  TextColumn get empregoId => text().references(DbEmpregos, #id)();
  TextColumn get vigencia => text().withLength(min: 7, max: 7)();
  RealColumn get valor => real()();
  BoolColumn get ativo => boolean()();
  @JsonKey('created_at')
  DateTimeColumn get createdAt => dateTime()();
}

class DbEmpregos extends Table {
  TextColumn get id => text().unique()();
  TextColumn get descricao => text()();
  DateTimeColumn get admissao => dateTime()();
  TextColumn get entrada => text().withLength(min: 5, max: 5)();
  TextColumn get saida => text().withLength(min: 5, max: 5)();
  @JsonKey('banco_horas')
  BoolColumn get bancoHoras => boolean()();
  @JsonKey('porc_normal')
  IntColumn get porcNormal => integer().withDefault(const Constant(50))();
  @JsonKey('porc_feriado')
  IntColumn get porcFeriado => integer().withDefault(const Constant(100))();
  BoolColumn get ativo => boolean().withDefault(const Constant(false))();
  @JsonKey('carga_horaria')
  IntColumn get cargaHoraria => integer().withDefault(const Constant(220))();
  @JsonKey('created_at')
  DateTimeColumn get createdAt => dateTime()();
}

@DriftDatabase(tables: [DbHoras, DbSalarios, DbEmpregos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'marcaii',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
