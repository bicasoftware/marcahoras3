import '../dtos.dart';

abstract class SalariosProviderContract {
  Future<SalariosDto> create(SalariosDto salario);
  Future<SalariosDto> update(SalariosDto salario);
  Future<void> delete(String salarioId);
  Future<void> deleteMany(String empregoId);
  Future<List<SalariosDto>> insertMany(List<SalariosDto> salarios);
}
