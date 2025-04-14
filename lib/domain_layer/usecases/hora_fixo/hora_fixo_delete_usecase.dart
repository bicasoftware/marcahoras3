import '../../../data_layer/repositories/hora_fixo_repository.dart';

class HoraFixoDeleteUseCase {
  final HoraFixoRepository _repo;

  const HoraFixoDeleteUseCase(HoraFixoRepository repository) : _repo = repository;

  Future<bool> call(String id) => _repo.deleteHoraFixo(id);
}