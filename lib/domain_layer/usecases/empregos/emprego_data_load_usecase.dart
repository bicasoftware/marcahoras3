import '../../../data_layer/respositories.dart';
import '../../models.dart';

class EmpregoDataLoadUseCase {
  final EmpregoRepository _repo;

  const EmpregoDataLoadUseCase(
    EmpregoRepository repository,
  ) : _repo = repository;

  Future<List<Empregos>> call(String from, String to) => _repo.list(from, to);
}
