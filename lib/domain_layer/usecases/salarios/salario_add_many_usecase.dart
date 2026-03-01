import '../../../data_layer/respositories.dart';
import '../../models.dart';

class SalariosAddManyUseCase {
  final SalariosRepository _repo;

  const SalariosAddManyUseCase(SalariosRepository repository)
    : _repo = repository;

  Future<List<Salarios>> call(List<Salarios> salarios) =>
      _repo.insertMany(salarios);
}
