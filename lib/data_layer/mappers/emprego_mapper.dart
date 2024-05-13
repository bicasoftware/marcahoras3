import '../../domain_layer/models.dart';
import '../../realm/realm_id_generator.dart';
import '../../utils/utils.dart';
import '../dtos.dart';
import '../realm_models/empregos_realm.dart';

extension EmpregoMapper on EmpregosDTO {
  Empregos toEmprego() {
    assertAllNotNull([id, admissao, entrada, saida]);
    return Empregos(
      id: id!,
      descricao: descricao!,
      admissao: admissao!,
      entrada: entrada!.toTimeOfDay(),
      saida: saida!.toTimeOfDay(),
      bancoHoras: bancoHoras ?? false,
      porcFeriado: porcFeriado ?? 0,
      porcNormal: porcNormal ?? 0,
      cargaHoraria: cargaHoraria ?? 220,
      ativo: ativo ?? false,
    );
  }
}

extension EmpregoDtoMapper on Empregos {
  EmpregosDTO toEmpregoDto() {
    assertAllNotNull([admissao, entrada, saida]);
    return EmpregosDTO(
      id: id,
      descricao: descricao,
      admissao: admissao,
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
  EmpregosDTO toEmpregosDto() {
    return EmpregosDTO(
      id: id,
      descricao: descricao,
      admissao: admissao,
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
extension EmpregosDtoToRealmMapper on EmpregosDTO {
  EmpregosRealm toRealmModel() {
    return EmpregosRealm(
      IdGenerator.generate(),
      descricao: descricao,
      admissao: admissao,
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
