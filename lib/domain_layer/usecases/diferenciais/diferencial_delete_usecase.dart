import '../../../data_layer/repositories/diferenciais_repository.dart';

class DiferencialDeleteUseCase {
  final DiferenciaisRepository _repo;

  const DiferencialDeleteUseCase(DiferenciaisRepository repository) : _repo = repository;

  Future<bool> call(String id) => _repo.deleteDiferencial(id);
}