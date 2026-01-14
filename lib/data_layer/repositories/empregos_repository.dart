import '../../domain_layer/contracts.dart';
import '../../domain_layer/models.dart';
import '../mappers/emprego_mapper.dart';

class EmpregoRepository implements EmpregosContract {
  final EmpregosProviderContract _provider;

  EmpregoRepository({
    required EmpregosProviderContract provider,
  }) : _provider = provider;

  @override
  Future<Empregos> create(Empregos e) async {
    final newEmprego = await _provider.create(e.toEmpregoDto());
    return newEmprego.toEmprego();
  }

  @override
  Future<Empregos> update(Empregos e) async {
    final updatedEmprego = await _provider.update(e.toEmpregoDto());
    return updatedEmprego.toEmprego();
  }

  @override
  Future<void> delete(String empregoId) async {
    await _provider.delete(empregoId);
  }

  @override
  Future<List<Empregos>> listByVigencia({
    required int year,
    required int month,
  }) async {
    final dtos = await _provider.listByVigencia(year: year, month: month);
    return dtos.map((e) => e.toEmprego()).toList();
  }
}
