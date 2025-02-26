import '../../../data_layer/dtos.dart';

abstract class EmpregosProviderContract {
  Future<List<EmpregosDto>> list(String from, String to);
  Future<EmpregosDto> create(EmpregosDto e);
  Future<EmpregosDto> update(EmpregosDto emprego);
  Future<void> delete(String empregoId);
}
