import '../../domain_layer/contracts.dart';
import '../../domain_layer/models.dart';
import '../mappers/emprego_mapper.dart';

class EmpregoRepository implements EmpregosContract {
  final EmpregosProviderContract _provider;

  EmpregoRepository(
    EmpregosProviderContract provider,
  ) : _provider = provider;

  @override
  Future<List<Empregos>> list(String from, String to) async {
    final dtos = await _provider.list(from, to);
    return dtos.map((e) => e.toEmprego()).toList();
  }

  @override
  Future<Empregos> append(Empregos e) async {
    final newEmprego = await _provider.append(e.toEmpregoDto());
    return newEmprego.toEmprego();
  }

  @override
  Future<Empregos> update(Empregos e) async {
    final dto = await _provider.update(e.toEmpregoDto());
    return dto.toEmprego();
  }

  @override
  Future<void> delete(String empregoId) async {
    await _provider.delete(empregoId);
  }
}
