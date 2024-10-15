
import '../../../data_layer/respositories.dart';
import '../../models.dart';

class HorasCreateUseCase {
  final HorasRepository _repo;

  HorasCreateUseCase({
    required HorasRepository repo,
  }) : _repo = repo;

  Future<Horas> call(Horas hora) => _repo.create(hora);
}
