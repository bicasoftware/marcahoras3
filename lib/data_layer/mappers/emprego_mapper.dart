import '../../domain_layer/models.dart';
import '../../utils/utils.dart';
import '../dtos.dart';

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
