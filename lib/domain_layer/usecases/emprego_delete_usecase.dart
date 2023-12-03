import '../../data_layer/respositories.dart';

class EmpregoDeleteUseCase {
  final EmpregoRepository _repo;

  EmpregoDeleteUseCase(EmpregoRepository repository) : _repo = repository;

  Future<void> call(int empregoId) => _repo.delete(empregoId);
}
