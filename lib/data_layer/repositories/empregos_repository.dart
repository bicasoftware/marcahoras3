import '../../domain_layer/contracts.dart';
import '../../domain_layer/models.dart';
import '../mappers/emprego_mapper.dart';
import '../providers.dart';

class EmpregoRepository implements EmpregosContract {
  final EmpregosProvider _provider;

  EmpregoRepository(
    EmpregosProvider provider,
  ) : _provider = provider;

  @override
  Future<List<Empregos>> list() async {
    final dtos = await _provider.list();
    return dtos.map((e) => e.toEmprego()).toList();
  }

  @override
  Future<Empregos> append(Empregos e) async {
    final newEmprego = await _provider.append(e.toEmpregoDto());
    return newEmprego.toEmprego();
  }

  @override
  Future<void> delete(int empregoId) async {
    await _provider.delete(empregoId);
  }
}
