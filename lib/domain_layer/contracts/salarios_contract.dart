import '../models.dart';

abstract class SalariosContract {
  Future<List<Salarios>> list(String empregoId);
  Future<Salarios> create(Salarios salario);
  Future<void> delete(String salarioId);
}
