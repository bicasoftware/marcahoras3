import '../../domain_layer/models.dart';
import '../../utils/utils.dart';
import '../dtos.dart';

extension SalariosMapper on SalariosDto {
  Salarios toSalario() {
    assertAllNotNull([id, empregoId, vigencia]);

    return Salarios(
      id: id!,
      empregoId: empregoId!,
      vigencia: vigencia!,
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
      vigencia: vigencia,
      valor: valor.toDouble(),
      ativo: ativo,
    );
  }
}
