import '../../../data_layer/respositories.dart';
import '../../models.dart';

class ListFeriadosUseCase {
  final FeriadosRepository _repository;

  ListFeriadosUseCase({required FeriadosRepository repository})
    : _repository = repository;

  Future<List<Feriados>> call(int year) async {
    return await _repository.getFeriasByYear(year);
  }
}
