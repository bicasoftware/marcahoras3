import '../../../data_layer/repositories/diferenciais_repository.dart';
import '../../models/diferencial.dart';

class DiferencialUpdateUseCase {
  final DiferenciaisRepository _repo;

  const DiferencialUpdateUseCase(DiferenciaisRepository repository) : _repo = repository;

  Future<Diferencial> call(Diferencial diferencial) => _repo.updateDiferencial(diferencial);
}