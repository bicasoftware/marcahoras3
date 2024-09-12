// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../domain_layer/models.dart';
import '../../../../utils/utils.dart';

class EmpregosDetailState extends BaseState implements Equatable {
  final Empregos emprego;

  final bool isEditing;

  EmpregosDetailState({
    required Empregos emprego,
    this.isEditing = false,
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

  @override
  bool operator ==(covariant EmpregosDetailState other) {
    if (identical(this, other)) return true;

    return other.emprego == emprego;
  }

  @override
  int get hashCode => emprego.hashCode;

  EmpregosDetailState copyWith({
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
  }) {
    final updtEmprego = emprego ??
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

    return EmpregosDetailState(
      emprego: updtEmprego,
      status: status ?? this.status,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}
