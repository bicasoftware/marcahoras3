import '../../../data_layer/respositories.dart';
import '../../models.dart';

class HorasUpdateUseCase {
  final HorasRepository _repo;

  HorasUpdateUseCase({
    required HorasRepository repo,
  }) : _repo = repo;

  Future<Horas> call(Horas hora) => _repo.update(hora);
}
