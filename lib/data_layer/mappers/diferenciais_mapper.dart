import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';

import '../../domain_layer/models.dart';
import '../../resources/colors.dart';
import '../database/db_connector_drift.dart';
import '../dtos.dart';

extension DiferenciaisDtoMapper on DiferenciaisDto {
  DbDiferenciaisCompanion toCompanion({String? newId}) {
    return DbDiferenciaisCompanion(
      id: Value(newId ?? id!),
      idEmprego: Value(idEmprego!),
      percentage: Value(percentage!),
      weekday: Value(weekday!),
      color: Value(color!),
    );
  }

  Diferenciais toModel() {
    return Diferenciais(
      id: id,
      idEmprego: idEmprego ?? '',
      percentage: percentage ?? 50,
      weekday: weekday ?? 0,
      color: color != null ? Color(color!) : AppColors.porcDiferenciadaColor,
    );
  }
}

extension DiferenciaisModelMapper on Diferenciais {
  DiferenciaisDto toDto() {
    return DiferenciaisDto(
      id: id,
      idEmprego: idEmprego,
      weekday: weekday,
      percentage: percentage,
      color: color.toARGB32(),
    );
  }
}
