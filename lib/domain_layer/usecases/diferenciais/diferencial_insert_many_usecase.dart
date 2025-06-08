import '../../../data_layer/repositories/diferenciais_repository.dart';
import '../../models/diferenciais.dart';

class DiferencialInsertManyUseCase {
  final DiferenciaisRepository _repo;

  const DiferencialInsertManyUseCase(DiferenciaisRepository repository) : _repo = repository;

  Future<void> call(List<Diferenciais> diferenciais) => _repo.insertMany(diferenciais);
}