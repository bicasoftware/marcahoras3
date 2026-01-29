import 'package:drift/drift.dart';
import 'package:intl/intl.dart';

import '../../domain_layer/models.dart';
import '../../utils.dart';
import '../database/db_connector_drift.dart';
import '../dtos.dart';
import '../mappers.dart';

/// The default for a mapper extension class should be:
/// toModel()
/// toJson()
/// fromJson()
/// fromJsonList()
/// toCompanion()
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
      cargaHoraria: cargaHoraria ?? CargaHoraria.padrao.mensal,
      ativo: ativo ?? false,
      diaFechamento: diaFechamento!,
      salarios: salarios.map((s) => s.toSalario()).toList(),
      horas: horas.map((h) => h.toHoras()).toList(),
      horaFixoList: horaFixoList.map((f) => f.toModel()).toList(),
      diferenciaisList: diferenciaisList.map((d) => d.toModel()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'descricao': descricao,
      'admissao': admissao,
      'entrada': entrada,
      'saida': saida,
      'banco_horas': bancoHoras,
      'porc_normal': porcNormal,
      'porc_feriado': porcFeriado,
      'ativo': ativo,
      'carga_horaria': cargaHoraria,
      'dia_fechamento': diaFechamento,
    };

    if (id != null) {
      data['id'] = id;
    }

    return data;
  }

  static EmpregosDto fromJson(
    dynamic e, {
    dynamic horas,
    dynamic salarios,
    dynamic horaFixo,
    dynamic diferenciais,
  }) {
    final emprego = EmpregosDto(
      id: e['id'],
      descricao: e['descricao'],
      admissao: e['admissao'] is int
          ? parseDateFromMillis(e['admissao'])
          : e['admissao'] as String,
      entrada: e['entrada'],
      saida: e['saida'],
      bancoHoras: e['banco_horas'] != null ? e['banco_horas'] as bool : null,
      porcNormal: e['porc_normal'],
      porcFeriado: e['porc_feriado'],
      ativo: e['ativo'] != null ? e['ativo'] as bool : null,
      diaFechamento: e['dia_fechamento'] != null
          ? e['dia_fechamento'] as int
          : null,
      cargaHoraria: e['carga_horaria'],
      createdAt: e['created_at'] is int
          ? getDateFromMillis(e['created_at'])
          : parseDate(e['created_at']),

      horas: horas != null ? HorasMapper.fromJsonList(horas) : [],
      salarios: salarios != null ? SalariosMapper.fromJsonList(salarios) : [],
      horaFixoList: horaFixo != null
          ? HoraFixoDtoMapper.fromJsonList(horaFixo)
          : [],
      diferenciaisList: diferenciais != null
          ? DiferenciaisDtoMapper.fromJsonList(diferenciais)
          : [],
    );

    return emprego;
  }

  static List<EmpregosDto> fromJsonList(List<dynamic> data) {
    return data.map((e) => fromJson(e)).toList();
  }

  DbEmpregosCompanion toCompanion({
    String? newId,
  }) {
    return DbEmpregosCompanion(
      id: Value(newId ?? id!),
      descricao: Value(descricao!),
      admissao: Value(parseDate(admissao)!),
      entrada: Value(entrada!),
      saida: Value(saida!),
      bancoHoras: Value(bancoHoras ?? false),
      porcFeriado: Value(porcFeriado ?? 0),
      porcNormal: Value(porcNormal ?? 0),
      cargaHoraria: Value(cargaHoraria ?? CargaHoraria.padrao.mensal),
      diaFechamento: Value(diaFechamento!),
      ativo: Value(ativo ?? false),
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
      diaFechamento: diaFechamento,
      salarios: mapChildren
          ? this.salarios.map((s) => s.toSalarioDto()).toList()
          : [],
      horas: mapChildren ? this.horas.map((h) => h.toHorasDto()).toList() : [],
      horaFixoList: mapChildren
          ? this.horaFixoList.map((f) => f.toDto()).toList()
          : [],
      diferenciaisList: mapChildren
          ? this.diferenciaisList.map((d) => d.toDto()).toList()
          : [],
    );
  }
}
