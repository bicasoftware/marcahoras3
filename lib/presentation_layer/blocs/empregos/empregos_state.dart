import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../utils.dart';

@immutable
class EmpregosState extends BaseState {
  final bool isInsert;
  final Empregos _emprego, _oldEmprego;

  final UnmodifiableListView<Salarios> _salarios;
  final UnmodifiableListView<Diferenciais> _difList;
  final UnmodifiableListView<Horas> _horas;

  Empregos get emprego => _emprego;
  bool get hasChanged => _emprego == _oldEmprego;

  String get descricao => _emprego.descricao;
  DateTime? get admissao => _emprego.admissao;
  TimeOfDay get entrada => _emprego.entrada;
  TimeOfDay get saida => _emprego.saida;
  bool get bancoHoras => _emprego.bancoHoras;
  int get porcFeriado => _emprego.porcFeriado;
  int get porcNormal => _emprego.porcNormal;
  int get cargaHoraria => _emprego.cargaHoraria;
  int get diaFechamento => _emprego.diaFechamento;
  bool get ativo => _emprego.ativo;

  bool didChangeData(Empregos oldEmprego) {
    return [
      _emprego.descricao != oldEmprego.descricao,
      _emprego.admissao != oldEmprego.admissao,
      _emprego.entrada != oldEmprego.entrada,
      _emprego.saida != oldEmprego.saida,
      _emprego.bancoHoras != oldEmprego.bancoHoras,
      _emprego.porcFeriado != oldEmprego.porcFeriado,
      _emprego.porcNormal != oldEmprego.porcNormal,
      _emprego.cargaHoraria != oldEmprego.cargaHoraria,
      _emprego.diaFechamento != oldEmprego.diaFechamento,
      _emprego.ativo != oldEmprego.ativo,
      !DeepCollectionEquality().equals(_salarios, oldEmprego.salarios),
      !DeepCollectionEquality().equals(_difList, oldEmprego.diferenciaisList),
    ].any((it) => it);
  }

  EmpregosState({
    required super.status,
    required this.isInsert,
    required Empregos emprego,
  }) : _emprego = emprego.copyWith(),
       _oldEmprego = emprego,
       this._salarios = UnmodifiableListView(emprego.salarios),
       this._difList = UnmodifiableListView(emprego.diferenciaisList),
       this._horas = UnmodifiableListView(emprego.horas);

  EmpregosState copyWith({
    StateStatus? status,
    bool? isInsert,
    Empregos? emprego,
    String? id,
    String? descricao,
    DateTime? admissao,
    TimeOfDay? entrada,
    TimeOfDay? saida,
    bool? bancoHoras,
    int? porcFeriado,
    int? porcNormal,
    int? cargaHoraria,
    bool? ativo,
    int? diaFechamento,
    bool? showValorFixadoTile,
    List<Salarios>? salarios,
    List<Diferenciais>? diferenciadas,
    List<Horas>? horas,
  }) {
    return EmpregosState(
      isInsert: isInsert ?? this.isInsert,
      status: status ?? this.status,
      emprego:
          emprego ??
          this._emprego.copyWith(
            descricao: descricao ?? this._emprego.descricao,
            admissao: admissao ?? this._emprego.admissao,
            entrada: entrada ?? this._emprego.entrada,
            saida: saida ?? this._emprego.saida,
            bancoHoras: bancoHoras ?? this._emprego.bancoHoras,
            porcFeriado: porcFeriado ?? this._emprego.porcFeriado,
            porcNormal: porcNormal ?? this._emprego.porcNormal,
            cargaHoraria: cargaHoraria ?? this._emprego.cargaHoraria,
            diaFechamento: diaFechamento ?? this._emprego.diaFechamento,
            ativo: ativo ?? this._emprego.ativo,
            diferenciaisList: diferenciadas ?? this._difList,
            horas: horas ?? this._horas,
            salarios: salarios ?? this._salarios,
          ),
    );
  }

  List<Horas> get horasList => _horas;
  List<Salarios> get salariosList => _salarios;
  List<Diferenciais> get difList => _difList;

  Salarios getCurrentSalario() {
    if (_salarios.length == 1) {
      return _salarios.first;
    }
    return _salarios
        .sorted(
          (Salarios a, Salarios b) => compareVigencias(a.vigencia, b.vigencia),
        )
        .last;
  }

  bool isValidSalario() {
    return isInsert ? _salarios.first.valor > 0 : _salarios.isNotEmpty;
  }

  EmpregosState setSalario(double salario) {
    assert(salariosList.length == 1);
    return this.copyWith(
      salarios: _salarios.iUpdateItem(
        original: _salarios.first,
        fresh: _salarios.first.copyWith(empregoId: _emprego.id, valor: salario),
      ),
    );
  }

  EmpregosState addAumento(double valor, String vigencia) {
    return this.copyWith(
      salarios: [
        ..._salarios,
        Salarios(
          id: generateId(),
          empregoId: _emprego.id!,
          valor: valor,
          vigencia: vigencia,
          ativo: true,
        ),
      ],
    );
  }

  EmpregosState deleteSalario(Salarios salario) {
    return this.copyWith(
      salarios: salariosList.iDelete(salario),
    );
  }

  EmpregosState editSalario({
    required Salarios fresh,
    required Salarios original,
  }) {
    return this.copyWith(
      salarios: salariosList.iUpdateItem(
        original: original,
        fresh: fresh,
      ),
    );
  }

  EmpregosState addDiferenciada({
    required int porc,
    required int weekDay,
    required Color color,
  }) {
    return this.copyWith(
      diferenciadas: [
        ...this._difList,
        Diferenciais(
          id: generateId(),
          idEmprego: _emprego.id!,
          weekday: weekDay,
          percentage: porc,
          color: color,
        ),
      ],
    );
  }

  EmpregosState deleteDiferenciada(Diferenciais dif) {
    return this.copyWith(diferenciadas: _difList.iDelete(dif));
  }

  EmpregosState editDiferenciada({
    required Diferenciais original,
    required Diferenciais fresh,
  }) {
    return this.copyWith(
      diferenciadas: this.difList.iUpdateItem(fresh: fresh, original: original),
    );
  }

  @override
  bool operator ==(covariant EmpregosState other) {
    if (identical(this, other)) return true;

    return other.isInsert == isInsert &&
        other._oldEmprego == _oldEmprego &&
        other._salarios == _salarios &&
        other._difList == _difList &&
        other._horas == _horas;
  }

  @override
  int get hashCode {
    return isInsert.hashCode ^
        _oldEmprego.hashCode ^
        _salarios.hashCode ^
        _difList.hashCode ^
        _horas.hashCode;
  }

  @override
  String toString() {
    return 'EmpregosStateAlt(isInsert: $isInsert, _oldEmprego: $_oldEmprego, _salarios: $_salarios, _difList: $_difList, _horas: $_horas)';
  }
}
