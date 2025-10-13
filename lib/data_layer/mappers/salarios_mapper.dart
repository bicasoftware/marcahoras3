import 'package:drift/drift.dart';

import '../../domain_layer/models.dart';
import '../../utils/date_utils.dart';
import '../database/db_connector_drift.dart';
import '../dtos.dart';

extension SalariosMapper on SalariosDto {
  Salarios toSalario() {
    return Salarios(
      id: id,
      empregoId: empregoId!,
      vigencia: parseVigencia(vigencia!),
      valor: valor?.toDouble() ?? 0.0,
      ativo: ativo ?? false,
    );
  }

  DbSalariosCompanion toCompanion({
    String? newId,
  }) {
    return DbSalariosCompanion(
      id: Value(newId ?? id!),
      empregoId: Value(empregoId!),
      vigencia: Value(vigencia!),
      valor: Value(valor?.toDouble() ?? 0.0),
      ativo: Value(ativo ?? false),
    );
  }
}

extension SalariosDtoMapper on Salarios {
  SalariosDto toSalarioDto() {
    return SalariosDto(
      id: id,
      empregoId: empregoId,
      vigencia: formatVigenciaDate(vigencia),
      valor: valor.toDouble(),
      ativo: ativo,
    );
  }
}
