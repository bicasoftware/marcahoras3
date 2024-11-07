import 'package:intl/intl.dart';
import 'package:realm/realm.dart';

import '../../domain_layer/models.dart';
import '../../utils/utils.dart';
import '../dtos.dart';
import '../tables/realm_models.dart';
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
      salarios: salarios?.map((s) => s.toSalario()).toList() ?? [],
      horas: horas?.map((h) => h.toHoras()).toList() ?? [],
    );
  }

  EmpregosRealm toRealm() {
    return EmpregosRealm(
      Uuid.v4().toString(),
      descricao: this.descricao,
      admissao: parseDate(admissao),
      entrada: entrada,
      saida: saida,
      bancoHoras: bancoHoras ?? false,
      porcFeriado: porcFeriado ?? 0,
      porcNormal: porcNormal ?? 0,
      cargaHoraria: cargaHoraria ?? 220,
      ativo: ativo ?? false,
    );
  }
}

extension EmpregoDtoMapper on Empregos {
  EmpregosDto toEmpregoDto() {
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
    );
  }
}

extension EmpregosRealmHelper on EmpregosRealm {
  EmpregosDto toDto([bool mapChildren = false]) {
    return EmpregosDto(
      id: id,
      descricao: descricao,
      admissao: DateFormat("yyyy-MM-dd").format(admissao ?? DateTime.now()),
      entrada: entrada,
      saida: saida,
      bancoHoras: bancoHoras,
      porcFeriado: porcFeriado,
      porcNormal: porcNormal,
      cargaHoraria: cargaHoraria,
      ativo: ativo,
      salarios: mapChildren ? this.salarios.map((s) => s.toDto()).toList() : null,
      horas: mapChildren ? this.horas.map((h) => h.toDto()).toList() : null,
    );
  }

  void updateFromDto(EmpregosDto dto) {
    this.id = dto.id ?? this.id;
    this.descricao = dto.descricao ?? this.descricao;
    this.admissao = parseDate(dto.admissao) ?? this.admissao;
    this.entrada = dto.entrada ?? this.entrada;
    this.saida = dto.saida ?? this.saida;
    this.bancoHoras = dto.bancoHoras ?? this.bancoHoras;
    this.porcFeriado = dto.porcFeriado ?? this.porcFeriado;
    this.porcNormal = dto.porcNormal ?? this.porcNormal;
    this.cargaHoraria = dto.cargaHoraria ?? this.cargaHoraria;
    this.ativo = dto.ativo ?? this.ativo;
  }
}
