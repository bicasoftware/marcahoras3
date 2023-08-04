import 'package:marcahoras3/data_layer/dtos/empregos_dto.dart';
import 'package:marcahoras3/utils/date_utils.dart';
import 'package:marcahoras3/utils/extensions/timeofdayutils.dart';

import '../../domain_layer/models.dart';

extension EmpregoMapper on EmpregosDTO {
  Empregos toEmprego() {
    return Empregos(
      descricao: descricao ?? '',
      inicio: formatDate(inicio),
      entrada: (entrada ?? '08:00').toTimeOfDay(),
      saida: (saida ?? '16:00').toTimeOfDay(),
      extra: extra ?? 0,
      extraFeriado: extraFeriado ?? 0,
      cargaHoraria: cargaHoraria ?? 220,
    );
  }
}