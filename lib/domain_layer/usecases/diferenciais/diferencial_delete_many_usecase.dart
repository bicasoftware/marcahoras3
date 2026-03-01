import '../../../data_layer/repositories/diferenciais_repository.dart';

class DiferencialDeleteManyUseCase {
  final DiferenciaisRepository _repo;

  const DiferencialDeleteManyUseCase(DiferenciaisRepository repository)
    : _repo = repository;

  Future<void> call(String empregoId) => _repo.deleteMany(empregoId);
}
