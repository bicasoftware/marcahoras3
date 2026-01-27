import '../../data_layer/mappers/salarios_mapper.dart';
import '../contracts.dart';
import '../../domain_layer/models/salarios.dart';

class SalariosRepository implements SalariosContract {
  final SalariosProviderContract _provider;

  SalariosRepository({
    required SalariosProviderContract provider,
  }) : _provider = provider;

  @override
  Future<Salarios> create(Salarios salario) async {
    final newSalario = await _provider.create(salario.toSalarioDto());
    return newSalario.toSalario();
  }

  @override
  Future<Salarios> update(Salarios salario) async {
    final newSalario = await _provider.update(salario.toSalarioDto());
    return newSalario.toSalario();
  }

  @override
  Future<void> delete(String salarioId) async {
    await _provider.delete(salarioId);
  }
}
