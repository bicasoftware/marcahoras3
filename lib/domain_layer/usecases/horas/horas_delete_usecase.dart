
import '../../../data_layer/respositories.dart';
import '../../models.dart';

class HorasDeleteUseCase {
  final HorasRepository _repo;

  HorasDeleteUseCase({
    required HorasRepository repo,
  }) : _repo = repo;

  Future<void> call(Horas hora) => _repo.delete(hora.id!);
}
