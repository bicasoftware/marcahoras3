import '../../data_layer/mappers/salarios_mapper.dart';
import '../../domain_layer/contracts.dart';
import '../../domain_layer/models/salarios.dart';

class SalariosRepository implements SalariosContract {
  final SalariosProviderContract _provider, _sqlProvider;

  SalariosRepository({
    required SalariosProviderContract provider,
    required SalariosProviderContract sqlProvider,
  }) : _provider = provider,
       _sqlProvider = sqlProvider;

  @override
  Future<Salarios> create(Salarios salario) async {
    final result = await _provider.create(salario.toSalarioDto());
    final newSalario = await _sqlProvider.create(result);
    return newSalario.toSalario();
  }

  @override
  Future<Salarios> update(Salarios salario) async {
    final result = await _provider.update(salario.toSalarioDto());
    final newSalario = await _sqlProvider.update(result);
    return newSalario.toSalario();
  }

  @override
  Future<void> delete(String salarioId) async {
    await _provider.delete(salarioId);
    await _sqlProvider.delete(salarioId);    
  }
}
