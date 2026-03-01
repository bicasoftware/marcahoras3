import '../../../data_layer/respositories.dart';

class SalariosDeleteManyUseCase {
  final SalariosRepository _repo;

  const SalariosDeleteManyUseCase(SalariosRepository repository)
    : _repo = repository;

  Future<void> call(String empregoId) => _repo.deleteMany(empregoId);
}
