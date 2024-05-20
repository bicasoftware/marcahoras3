import '../../../data_layer/respositories.dart';
import '../../models.dart';

class EmpregoInsertUseCase {
  final EmpregoRepository _repo;

  EmpregoInsertUseCase(EmpregoRepository repository) : _repo = repository;

  Future<Empregos> call(Empregos e) => _repo.append(e);
}
