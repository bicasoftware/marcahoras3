import '../../../data_layer/dtos.dart';

abstract class EmpregosProviderContract {
  Future<List<EmpregosDto>> listByVigencia({
    required int year,
    required int month,
  });
  Future<EmpregosDto> create(EmpregosDto e);
  Future<EmpregosDto> update(EmpregosDto emprego);
  Future<void> delete(String empregoId);
}
