import '../../../data_layer/repositories/diferenciais_repository.dart';
import '../../models/diferenciais.dart';

class DiferencialUpdateUseCase {
  final DiferenciaisRepository _repo;

  const DiferencialUpdateUseCase(DiferenciaisRepository repository) : _repo = repository;

  Future<Diferenciais?> call(Diferenciais diferencial) => _repo.updateDiferencial(diferencial);
}