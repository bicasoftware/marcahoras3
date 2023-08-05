import '../../domain_layer/models.dart';

extension SalariosHelper on Salarios {
  String generateCreateTableStatement() {
    return '''
      CREATE TABLE salarios (
        id INTEGER PRIMARY KEY,
        emprego_id INTEGER,
        valor REAL,
        inicio TEXT
      );
    ''';
  }
}
