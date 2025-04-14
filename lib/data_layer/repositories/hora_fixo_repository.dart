import '../../domain_layer/contracts.dart';
import '../../domain_layer/models/hora_fixo.dart';

class HoraFixoRepository {
  final HoraFixoProviderContract _provider;

  HoraFixoRepository({required HoraFixoProviderContract provider})
    : _provider = provider;

  Future<HoraFixo?> saveHoraFixo(HoraFixo horaFixo) async {
    final fixo = await _provider.insertHoraFixo(horaFixo.toDTO());
    return HoraFixo.fromDTO(fixo);
  }

  Future<HoraFixo?> updateHoraFixo(HoraFixo horaFixo) async {
    final updatedFixo = await _provider.updateHoraFixo(horaFixo.toDTO());
    return HoraFixo.fromDTO(updatedFixo);
  }

  Future<bool> deleteHoraFixo(String id) async {
    return await _provider.deleteHoraFixo(id);
  }
}
