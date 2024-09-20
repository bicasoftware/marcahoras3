import 'package:intl/intl.dart';
import 'package:marcahoras3/data_layer/mappers/horas_mapper.dart';
import 'package:marcahoras3/data_layer/mappers/salarios_mapper.dart';
import 'package:marcahoras3/data_layer/repositories/horas_repository.dart';
import 'package:marcahoras3/data_layer/repositories/salarios_repository.dart';

import '../../domain_layer/models.dart';
import '../../realm/realm_id_generator.dart';
import '../../utils/utils.dart';
import '../dtos.dart';
import '../realm_models/empregos_realm.dart';

extension EmpregoMapper on EmpregosDto {
  Empregos toEmprego() {
    return Empregos(
      id: id,
      descricao: descricao ?? '',
      admissao: DateFormat("yyyy-MM-dd").parse(admissao!),
      entrada: entrada!.toTimeOfDay(),
      saida: saida!.toTimeOfDay(),
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
      entrada: entrada.asString(),
      saida: saida.asString(),
      bancoHoras: bancoHoras,
      porcFeriado: porcFeriado,
      porcNormal: porcNormal,
      cargaHoraria: cargaHoraria,
      ativo: ativo,
    );
  }
}

extension EmpregosRealmDtoMapper on EmpregosRealm {
  EmpregosDto toEmpregosDto() {
    return EmpregosDto(
      id: id,
      descricao: descricao,
      admissao: DateFormat("yyyy-MM-dd").format(admissao!),
      entrada: entrada,
      saida: saida,
      bancoHoras: bancoHoras,
      porcNormal: porcNormal,
      porcFeriado: porcFeriado,
      ativo: ativo,
      cargaHoraria: cargaHoraria,
    );
  }
}

// extension EmpregosModelToRealmDtoMapper on Empregos {
//   EmpregosRealm toEmpregos() {
//     return EmpregosRealm(
//       IdGenerator.generate(),
//       descricao: descricao,
//       admissao: admissao,
//       entrada: entrada.asString(),
//       saida: saida.asString(),
//       bancoHoras: bancoHoras,
//       porcNormal: porcNormal,
//       porcFeriado: porcFeriado,
//       ativo: ativo,
//       cargaHoraria: cargaHoraria,
//     );
//   }
// }
extension EmpregosDtoToRealmMapper on EmpregosDto {
  EmpregosRealm toRealmModel() {
    return EmpregosRealm(
      IdGenerator.generate(),
      descricao: descricao,
      admissao: DateFormat("yyyy-MM-dd").parse(admissao!),
      entrada: entrada,
      saida: saida,
      bancoHoras: bancoHoras ?? false,
      porcNormal: porcNormal ?? 50,
      porcFeriado: porcFeriado ?? 100,
      ativo: ativo ?? true,
      cargaHoraria: cargaHoraria ?? 220,
    );
  }
}
