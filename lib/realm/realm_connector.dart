import 'package:marcahoras3/data_layer/realm_models/empregos_realm.dart';
import 'package:marcahoras3/data_layer/realm_models/horas_realm.dart';
import 'package:marcahoras3/data_layer/realm_models/salarios_realm.dart';
import 'package:realm/realm.dart';

class RealmConnector {
  static final RealmConnector _connector = RealmConnector._internal();

  static late final Realm _realm;

  factory RealmConnector() {
    return _connector;
  }

  RealmConnector._internal() {
    final config = Configuration.local([
      HorasRealm.schema,
      SalariosRealm.schema,
      EmpregosRealm.schema,
    ]);

    _realm = Realm(config);
  }

  Realm get realm => _realm;

  void cleanAll() {
    _realm.write(() {
      _realm.deleteAll<SalariosRealm>();
      _realm.deleteAll<HorasRealm>();
      _realm.deleteAll<EmpregosRealm>();
    });
  }
}
