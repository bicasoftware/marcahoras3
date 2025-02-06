import 'package:drift/drift.dart';
import 'package:realm/realm.dart';

import '../../domain_layer/models.dart';
import '../../utils/date_utils.dart';
import '../database/db_connector_drift.dart';
import '../dtos.dart';
import '../tables/realm_models.dart';

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

  SalariosRealm toRealm() {
    return SalariosRealm(
      id ?? Uuid.v4().toString(),
      ativo: ativo,
      valor: valor?.toDouble(),
      vigencia: vigencia,
      empregoId: empregoId,
    );
  }

  DbSalariosCompanion toCompanion({String? newId}) {
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

extension SalariosRealmDtoMapper on SalariosRealm {
  SalariosDto toDto() {
    return SalariosDto(
      id: id,
      vigencia: vigencia,
      valor: valor,
      ativo: ativo,
      empregoId: empregoId,
    );
  }

  void updateFromDto(SalariosDto salario) {
    vigencia = salario.vigencia ?? this.vigencia;
    valor = salario.valor?.toDouble() ?? this.valor ?? 0.0;
    ativo = salario.ativo ?? this.ativo;
  }
}
