import 'package:marcahoras3/domain_layer/models/salarios.dart';

import '../../domain_layer/contracts.dart';
import '../../data_layer/mappers/salarios_mapper.dart';
import '../providers.dart';

class SalariosRepository implements SalariosContract {
  final SalariosProvider _provider;

  SalariosRepository({
    required SalariosProvider provider,
  }) : _provider = provider;

  @override
  Future<Salarios> create(Salarios salario) async {
    final newSalario = await _provider.create(salario.toSalarioDto());
    return newSalario.toSalario();
  }

  @override
  Future<List<Salarios>> list(String empregoId) async {
    final salarios = await _provider.list(empregoId);
    return salarios.map((s) => s.toSalario()).toList();
  }

  @override
  Future<void> delete(String salarioId) async {
    await _provider.delete(salarioId);
  }
}
