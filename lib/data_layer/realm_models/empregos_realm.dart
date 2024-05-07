import 'package:realm/realm.dart';

part 'empregos_realm.realm.dart';

@RealmModel()
class _EmpregosRealm {
  late String id;
  String? descricao;
  DateTime? admissao;
  bool ativo = true;
  bool bancoHoras = false;
  int cargaHoraria = 220;
  String? entrada;
  String? saida;
  int porcNormal = 50;
  int porcFeriado = 100;
}
