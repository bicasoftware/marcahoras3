import '../../../data_layer/repositories/hora_fixo_repository.dart';
import '../../models/hora_fixo.dart';

class HoraFixoSaveUseCase {
  final HoraFixoRepository _repo;

  const HoraFixoSaveUseCase(HoraFixoRepository repository) : _repo = repository;

  Future<HoraFixo?> call(HoraFixo horaFixo) => _repo.saveHoraFixo(horaFixo);
}