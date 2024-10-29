import 'package:intl/intl.dart';

import '../../domain_layer/models.dart';
import '../../utils/utils.dart';
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
      salarios: salarios?.map((s) => s.toSalario()).toList() ?? [],
      horas: horas?.map((h) => h.toHoras()).toList() ?? [],
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
