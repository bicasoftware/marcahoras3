import '../../domain_layer/models.dart';
import '../../utils/date_utils.dart';
import '../dtos.dart';

extension SalariosMapper on SalariosDto {
  Salarios toSalario() {
    return Salarios(
      id: id!,
      empregoId: empregoId!,
      vigencia: parseVigencia(vigencia!),
      valor: valor?.toDouble() ?? 0.0,
      ativo: ativo ?? false,
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
