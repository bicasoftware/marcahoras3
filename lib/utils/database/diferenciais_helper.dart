import '../../domain_layer/models.dart';

extension DiferenciaisExtension on Diferenciais {
  static String get tableName => 'diferenciais';

  static String get createTableQuery => '''
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY,
      emprego_id INTEGER,
      porcentagem INTEGER,
      inicio TEXT,
      weekday INTEGER
    )
  ''';

  // You can also add other extension methods here for your Diferenciais class if needed.
}
