import '../../../data_layer/respositories.dart';
import '../../models.dart';

class SalarioUpdateUseCase {
  final SalariosRepository _repo;

  const SalarioUpdateUseCase(SalariosRepository repository)
      : _repo = repository;

  Future<Salarios> call(Salarios e) => _repo.update(e);
}
