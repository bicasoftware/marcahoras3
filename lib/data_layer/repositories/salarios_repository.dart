import '../../data_layer/mappers/salarios_mapper.dart';
import '../../domain_layer/models/salarios.dart';
import '../contracts.dart';

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

  @override
  Future<List<Salarios>> insertMany(List<Salarios> salarios) async {
    await _provider.insertMany(salarios.map((s) => s.toSalarioDto()).toList());
    return salarios;
  }

  @override
  Future<void> deleteMany(String empregoId) async {
    await _provider.deleteMany(empregoId);
  }
}
