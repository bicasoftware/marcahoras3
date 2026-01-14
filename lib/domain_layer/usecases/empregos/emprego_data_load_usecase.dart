import '../../../data_layer/respositories.dart';
import '../../models.dart';

class EmpregoDataLoadByVigenciaUseCase {
  final EmpregoRepository _repo;

  const EmpregoDataLoadByVigenciaUseCase(
    EmpregoRepository repository,
  ) : _repo = repository;

  Future<List<Empregos>> call(int year, int month) => _repo.listByVigencia(
    year: year,
    month: month,
  );
}
