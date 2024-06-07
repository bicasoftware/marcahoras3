import '../../../data_layer/respositories.dart';
import '../../models.dart';

class EmpregoDataLoadUseCase {
  final EmpregoRepository _repo;

  EmpregoDataLoadUseCase(
    EmpregoRepository repository,
  ) : _repo = repository;

  Future<List<Empregos>> call() => _repo.list();
}