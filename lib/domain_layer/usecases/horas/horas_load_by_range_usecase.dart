import '../../../data_layer/respositories.dart';
import '../../models.dart';

class HorasLoadByRangeUseCase {
  final HorasRepository _repo;

  const HorasLoadByRangeUseCase(
    HorasRepository repository,
  ) : _repo = repository;

  Future<List<Horas>> call(String empregoId, String from, String to) {
    return _repo.list(empregoId, from, to);
  }
}
