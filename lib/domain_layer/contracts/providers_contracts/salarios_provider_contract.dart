import '../../../data_layer/dtos.dart';

abstract class SalariosProviderContract {
  Future<List<SalariosDto>> list(String empregoId);
  Future<SalariosDto> create(SalariosDto salario);
  Future<SalariosDto> update(SalariosDto salario);
  Future<void> delete(String salarioId);
}
