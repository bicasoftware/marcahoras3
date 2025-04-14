import 'package:drift/drift.dart';
import 'package:marcahoras3/data_layer/database/db_connector_drift.dart';

import '../../domain_layer/models.dart';
import '../dtos.dart';

extension DiferenciaisDtoMapper on DiferenciaisDTO {
  DbDiferenciaisCompanion toCompanion({String? newId}) {
    return DbDiferenciaisCompanion(
      id: Value(newId ?? id),
      idEmprego: Value(idEmprego),
      percentage: Value(percentage),
      weekday: Value(weekday),
    );
  }

  Diferencial toModel() {
    return Diferencial(
      id: id,
      idEmprego: idEmprego,
      percentage: percentage,
      weekday: weekday,
    );
  }
}

extension DiferenciaisModelMapper on Diferencial {
  DiferenciaisDTO toDto() {
    return DiferenciaisDTO(
      id: id,
      idEmprego: idEmprego,
      weekday: weekday,
      percentage: percentage,
    );
  }
}
