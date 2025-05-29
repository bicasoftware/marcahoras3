import '../../../data_layer/repositories/diferenciais_repository.dart';
import '../../models/diferenciais.dart';

class DiferencialSaveUseCase {
  final DiferenciaisRepository _repo;

  const DiferencialSaveUseCase(DiferenciaisRepository repository) : _repo = repository;

  Future<Diferenciais?> call(Diferenciais diferencial) => _repo.saveDiferencial(diferencial);
}