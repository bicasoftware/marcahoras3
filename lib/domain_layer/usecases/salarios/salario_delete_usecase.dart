import '../../../data_layer/respositories.dart';

class SalarioDeleteUseCase {
  final SalariosRepository _repo;

  const SalarioDeleteUseCase(SalariosRepository repository)
      : _repo = repository;

  Future<void> call(String salarioId) => _repo.delete(salarioId);
}
