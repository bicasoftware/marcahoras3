import '../../../data_layer/repositories/diferenciais_repository.dart';
import '../../models/diferencial.dart';

class DiferencialSaveUseCase {
  final DiferenciaisRepository _repo;

  const DiferencialSaveUseCase(DiferenciaisRepository repository) : _repo = repository;

  Future<Diferencial> call(Diferencial diferencial) => _repo.saveDiferencial(diferencial);
}