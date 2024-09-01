import '../../../data_layer/respositories.dart';
import '../../models.dart';

class SalarioCreateUseCase {
  final SalariosRepository _repo;

  const SalarioCreateUseCase(SalariosRepository repository)
      : _repo = repository;

  Future<Salarios> call(Salarios e) => _repo.create(e);
}
