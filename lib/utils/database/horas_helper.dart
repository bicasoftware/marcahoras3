import '../../domain_layer/models.dart';

extension HorasHelper on Horas {
  String createStringQuery() {
    return '''
    CREATE TABLE horas (
      id INTEGER PRIMARY KEY,
      emprego_id INTEGER,
      tipo_hora INTEGER,
      banco_horas INTEGER,
      data DATE
    );
  ''';
  }
}
