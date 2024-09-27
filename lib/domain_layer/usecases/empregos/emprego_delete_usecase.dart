import '../../../data_layer/respositories.dart';

class EmpregoDeleteUseCase {
  final EmpregoRepository _repo;

  const EmpregoDeleteUseCase(EmpregoRepository repository) : _repo = repository;

  Future<void> call(String empregoId) async => _repo.delete(empregoId);
}
