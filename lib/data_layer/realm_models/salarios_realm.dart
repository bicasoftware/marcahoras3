import 'package:realm/realm.dart';

part 'salarios_realm.realm.dart';

@RealmModel()
class _SalariosRealm {
  late String id;
  String? empregoId;
  double? valor;
  String? vigencia;
}
