import '../../../data_layer/respositories.dart';
import '../../models.dart';

class EmpregoUpdateUseCase {
  final EmpregoRepository _repo;

  const EmpregoUpdateUseCase(EmpregoRepository repository) : _repo = repository;

  Future<Empregos> call(Empregos e) => _repo.update(e);
}
