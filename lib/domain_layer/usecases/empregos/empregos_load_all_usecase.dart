import '../../../data_layer/dtos.dart';
import '../../../data_layer/providers.dart';

class EmpregosLoadAllUseCase {
  final EmpregosProvider _provider;

  const EmpregosLoadAllUseCase(
    EmpregosProvider provider,
  ) : _provider = provider;

  Future<List<EmpregosDto>> call() => _provider.list();
}
