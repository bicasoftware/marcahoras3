import 'package:drift/drift.dart';

import '../../domain_layer/models/hora_fixo.dart';
import '../../utils.dart';
import '../database/db_connector_drift.dart';
import '../dtos.dart';

extension HoraFixoDtoMapper on HoraFixoDto {
  DbHoraFixoCompanion toCompanion({String? newId}) {
    return DbHoraFixoCompanion(
      id: Value(newId!),
      idEmprego: Value(idEmprego!),
      valorNormal: Value(valorNormal ?? 0.0),
      valorFeriado: Value(valorFeriado ?? 0.0),
      vigencia: Value(vigencia!),
    );
  }

  HoraFixo toModel() {
    return HoraFixo(
      id: id,
      idEmprego: idEmprego!,
      valorNormal: valorNormal ?? 0.0,
      valorFeriado: valorFeriado ?? 0.0,
      vigencia: parseVigencia(vigencia!),
    );
  }
}

extension HoraFixoModelMapper on HoraFixo {
  HoraFixoDto toDto() {
    return HoraFixoDto(
      id: id,
      idEmprego: idEmprego,
      valorNormal: valorNormal,
      valorFeriado: valorFeriado,
      vigencia: formatVigenciaDate(vigencia),
    );
  }
}
