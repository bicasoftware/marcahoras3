import 'package:drift/drift.dart';
import 'package:marcahoras3/data_layer/database/db_connector_drift.dart';

import '../../domain_layer/models.dart';
import '../dtos.dart';

extension DiferenciaisDtoMapper on DiferenciaisDto {
  DbDiferenciaisCompanion toCompanion({String? newId}) {
    return DbDiferenciaisCompanion(
      id: Value(newId ?? id),
      idEmprego: Value(idEmprego),
      percentage: Value(percentage),
      weekday: Value(weekday),
    );
  }

  Diferenciais toModel() {
    return Diferenciais(
      id: id,
      idEmprego: idEmprego,
      percentage: percentage,
      weekday: weekday,
    );
  }
}

extension DiferenciaisModelMapper on Diferenciais {
  DiferenciaisDto toDto() {
    return DiferenciaisDto(
      id: id!,
      idEmprego: idEmprego,
      weekday: weekday,
      percentage: percentage,
    );
  }
}
