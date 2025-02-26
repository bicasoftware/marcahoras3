import '../models.dart';

abstract class SalariosContract {
  Future<Salarios> create(Salarios salario);
  Future<Salarios> update(Salarios salario);
  Future<void> delete(String salarioId);
}
