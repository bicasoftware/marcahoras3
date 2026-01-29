import '../../../data_layer/respositories.dart';
import '../../models.dart';

class ListFeriadosUseCase {
  final FeriadosRepository _repository;

  ListFeriadosUseCase({required FeriadosRepository repository})
    : _repository = repository;

  Future<List<Anos>> call() async {
    return await _repository.getFeriados();
  }
}
