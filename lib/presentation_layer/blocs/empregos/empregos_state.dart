import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../utils.dart';

class EmpregosState extends BaseState {
  final Empregos emprego;

  final bool isEditing;
  final bool useValorFixo;
  final (double, double) valorFixo;

  EmpregosState({
    required Empregos emprego,
    this.isEditing = false,
    this.useValorFixo = false,
    this.valorFixo = (0, 0),
    required super.status,
  }) : emprego = emprego;

  DateTime? get admissao => emprego.admissao;
  String? get descricao => emprego.descricao;
  TimeOfDay? get entrada => emprego.entrada;
  TimeOfDay? get saida => emprego.saida;
  bool get bancoHoras => emprego.bancoHoras;
  int? get porcFeriado => emprego.porcFeriado;
  int? get porcNormal => emprego.porcNormal;
  int get cargaHoraria => emprego.cargaHoraria;
  bool? get ativo => emprego.ativo;
  double get salario => emprego.salario;
  List<Salarios> get salarios => emprego.salarios;

  EmpregosState copyWith({
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
    double? salario,
    StateStatus? status,
    Empregos? emprego,
    bool? isEditing,
    bool? useValorFixo,
    (double, double)? valorFixo,
  }) {
    final updtEmprego =
        emprego ??
        this.emprego.copyWith(
          descricao: descricao ?? this.emprego.descricao,
          admissao: admissao ?? this.emprego.admissao,
          entrada: entrada ?? this.emprego.entrada,
          saida: saida ?? this.emprego.saida,
          bancoHoras: bancoHoras ?? this.emprego.bancoHoras,
          porcFeriado: porcFeriado ?? this.emprego.porcFeriado,
          porcNormal: porcNormal ?? this.emprego.porcNormal,
          cargaHoraria: cargaHoraria ?? this.emprego.cargaHoraria,
          ativo: ativo ?? this.emprego.ativo,
          salario: salario ?? this.emprego.salario,
        );

    return EmpregosState(
      emprego: updtEmprego,
      status: status ?? this.status,
      isEditing: isEditing ?? this.isEditing,
      useValorFixo: useValorFixo ?? this.useValorFixo,
      valorFixo: valorFixo ?? this.valorFixo,
    );
  }

  EmpregosState emitLoading() => this.copyWith(status: StateLoadingStatus());

  bool get usingFixedValue {
    return emprego.horaFixoList.length > 0;
  }

  @override
  bool operator ==(covariant EmpregosState other) {
    if (identical(this, other)) return true;

    return other.emprego == emprego &&
        other.isEditing == isEditing &&
        other.valorFixo == valorFixo &&
        other.useValorFixo == useValorFixo;
  }

  @override
  int get hashCode =>
      emprego.hashCode ^ isEditing.hashCode ^ useValorFixo.hashCode;
}
