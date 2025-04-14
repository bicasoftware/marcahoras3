import '../../../data_layer/repositories/hora_fixo_repository.dart';
import '../../models/hora_fixo.dart';

class HoraFixoUpdateUseCase {
  final HoraFixoRepository _repo;

  const HoraFixoUpdateUseCase(HoraFixoRepository repository) : _repo = repository;

  Future<HoraFixo?> call(HoraFixo horaFixo) => _repo.updateHoraFixo(horaFixo);
}