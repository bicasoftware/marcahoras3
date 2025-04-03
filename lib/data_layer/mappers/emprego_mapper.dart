import 'package:drift/drift.dart';
import 'package:intl/intl.dart';

import '../../domain_layer/models.dart';
import '../../utils.dart';
import '../database/db_connector_drift.dart';
import '../dtos.dart';
import 'horas_mapper.dart';
import 'salarios_mapper.dart';

extension EmpregoMapper on EmpregosDto {
  Empregos toEmprego() {
    return Empregos(
      id: id,
      descricao: descricao ?? '',
      admissao: DateFormat("yyyy-MM-dd").parse(admissao!),
      entrada: TimeOfDayHelper.parseString(entrada!),
      saida: TimeOfDayHelper.parseString(saida!),
      bancoHoras: bancoHoras ?? false,
      porcFeriado: porcFeriado ?? 0,
      porcNormal: porcNormal ?? 0,
      cargaHoraria: cargaHoraria ?? 220,
      ativo: ativo ?? false,
      salarios: salarios.map((s) => s.toSalario()).toList(),
      horas: horas.map((h) => h.toHoras()).toList(),
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  DbEmpregosCompanion toCompanion({String? newId, required DateTime createdAt}) {
    return DbEmpregosCompanion(
      id: Value(newId ?? id!),
      descricao: Value(descricao!),
      admissao: Value(parseDate(admissao)!),
      entrada: Value(entrada!),
      saida: Value(saida!),
      bancoHoras: Value(bancoHoras ?? false),
      porcFeriado: Value(porcFeriado ?? 0),
      porcNormal: Value(porcNormal ?? 0),
      cargaHoraria: Value(cargaHoraria ?? 220),
      ativo: Value(ativo ?? false),
      createdAt: Value(createdAt),
    );
  }
}

extension EmpregoDtoMapper on Empregos {
  EmpregosDto toEmpregoDto([bool mapChildren = false]) {
    return EmpregosDto(
      id: id,
      descricao: descricao,
      admissao: DateFormat("yyyy-MM-dd").format(admissao ?? DateTime.now()),
      entrada: TimeOfDayHelper.formatTime(entrada),
      saida: TimeOfDayHelper.formatTime(saida),
      bancoHoras: bancoHoras,
      porcFeriado: porcFeriado,
      porcNormal: porcNormal,
      cargaHoraria: cargaHoraria,
      ativo: ativo,
      salarios: mapChildren
          ? this.salarios.map((s) => s.toSalarioDto()).toList()
          : [],
      horas: mapChildren ? this.horas.map((h) => h.toHorasDto()).toList() : [],
    );
  }
}
