import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

part 'horas_realm.realm.dart';

@RealmModel()
class _HorasRealm {
  late String id;
  String? empregoId;
  DateTime? data;
  String? inicio;
  String? termino;
  String tipoHora = 'n';
}
