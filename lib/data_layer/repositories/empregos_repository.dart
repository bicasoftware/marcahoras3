import '../../domain_layer/contracts.dart';
import '../../domain_layer/models.dart';
import '../mappers/emprego_mapper.dart';

class EmpregoRepository implements EmpregosContract {
  final EmpregosProviderContract _provider, _sqlProvider;

  EmpregoRepository({
    required EmpregosProviderContract provider,
    required EmpregosProviderContract sqlProvider,
  }) : _provider = provider,
       _sqlProvider = sqlProvider;

  @override
  Future<List<Empregos>> list({String? from, String? to}) async {
    final dtos = await _sqlProvider.list(from: from, to: to);
    return dtos.map((e) => e.toEmprego()).toList();
  }

  @override
  Future<Empregos> create(Empregos e) async {
    final result = await _provider.create(e.toEmpregoDto());
    final newEmprego = await _sqlProvider.create(result);
    return newEmprego.toEmprego();
  }

  @override
  Future<Empregos> update(Empregos e) async {
    final result = await _provider.update(e.toEmpregoDto());
    final updatedEmprego = await _sqlProvider.update(result);
    return updatedEmprego.toEmprego();
  }

  @override
  Future<void> delete(String empregoId) async {
    await _provider.delete(empregoId);
    await _sqlProvider.delete(empregoId);
  }
}
