import 'package:drift/drift.dart';
import 'package:marcahoras3/data_layer/database/db_connector_drift.dart';

import '../../domain_layer/models/hora_fixo.dart';
import '../dtos.dart';

extension HoraFixoDtoMapper on HoraFixoDTO {
  DbHoraFixoCompanion toCompanion({String? newId}) {
    return DbHoraFixoCompanion(
      id: Value(newId ?? id),
      idEmprego: Value(idEmprego),
      value: Value(value),
      vigencia: Value(vigencia),
    );
  }

  HoraFixo toModel() {
    return HoraFixo(
      id: id,
      idEmprego: idEmprego,
      value: value,
      vigencia: vigencia,
    );
  }
}

extension HoraFixoModelMapper on HoraFixo {
  HoraFixoDTO toDto() {
    return HoraFixoDTO(
      id: id,
      idEmprego: idEmprego,
      value: value,
      vigencia: vigencia,
    );
  }
}
