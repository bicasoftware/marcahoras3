import 'package:realm/realm.dart';

part 'realm_models.realm.dart';

@RealmModel()
class _EmpregosRealm {
  @PrimaryKey()
  late String? id;
  late String? descricao;
  late DateTime? admissao;
  late String? entrada;
  late String? saida;
  late bool? bancoHoras;
  late int? porcNormal;
  late int? porcFeriado;
  late bool? ativo;
  late int? cargaHoraria;
  late List<_SalariosRealm> salarios;
  late List<_HorasRealm> horas;
}

@RealmModel()
class _SalariosRealm {
  @PrimaryKey()
  late String? id;
  late String? vigencia;
  late double? valor;
  bool? ativo = true;

  @Backlink(#salarios)
  late Iterable<_EmpregosRealm> emprego;
}

@RealmModel()
class _HorasRealm {
  @PrimaryKey()
  late String? id;
  late DateTime? data;
  late String? inicio;
  late String? termino;
  late String? tipoHora;
  late bool? bancoHoras;

  @Backlink(#horas)
  late Iterable<_EmpregosRealm> emprego;
}
