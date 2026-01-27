import 'package:drift/drift.dart';
import 'package:sane_uuid/uuid.dart';

import '../../domain_layer/models.dart';
import '../database/db_connector_drift.dart';
import '../dtos.dart';

extension FeriadosMapper on FeriadosDto {
  Feriados toFeriado() {
    return Feriados(
      date: this.date!,
      name: this.name ?? '',
      type: this.type ?? '',
    );
  }

  DbFeriadosCompanion toCompanion() {
    return DbFeriadosCompanion(
      id: Value(Uuid.v4().toString()),
      date: Value(this.date!),
      name: Value(this.name ?? ''),
      type: Value(this.type ?? ''),
    );
  }
}

extension FeriadosDtoMapper on Feriados {
  FeriadosDto toFeriadoDto() {
    return FeriadosDto(
      date: this.date,
      name: this.name,
      type: this.type,
    );
  }
}
