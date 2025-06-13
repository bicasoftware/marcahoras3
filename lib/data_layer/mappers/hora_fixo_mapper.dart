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
      valorNormal: Value(valorNormal?.toDouble() ?? 0.0),
      valorFeriado: Value(valorFeriado?.toDouble() ?? 0.0),
      vigencia: Value(vigencia!),
    );
  }

  HoraFixo toModel() {
    return HoraFixo(
      id: id,
      idEmprego: idEmprego!,
      valorNormal: valorNormal?.toDouble() ?? 0.0,
      valorFeriado: valorFeriado?.toDouble() ?? 0.0,
      vigencia: parseVigencia(vigencia!),
    );
  }
}

extension HoraFixoModelMapper on HoraFixo {
  HoraFixoDto toDto([String? newId]) {
    return HoraFixoDto(
      id: newId ?? id,
      idEmprego: idEmprego,
      valorNormal: valorNormal,
      valorFeriado: valorFeriado,
      vigencia: formatVigenciaDate(vigencia),
    );
  }
}
