import 'package:marcahoras3/utils/uuid_factory.dart';

import '../../domain_layer/contracts.dart';
import '../../domain_layer/models/hora_fixo.dart';
import '../mappers/hora_fixo_mapper.dart';

class HoraFixoRepository {
  final HoraFixoProviderContract _provider;

  HoraFixoRepository({required HoraFixoProviderContract provider})
    : _provider = provider;

  Future<HoraFixo?> saveHoraFixo(HoraFixo horaFixo) async {
    final newId = UuidFactory.build();
    final fixo = await _provider.insertHoraFixo(horaFixo.toDto(newId));
    return fixo.toModel();
  }

  Future<HoraFixo?> updateHoraFixo(HoraFixo horaFixo) async {
    final updatedFixo = await _provider.updateHoraFixo(horaFixo.toDto());
    return updatedFixo.toModel();
  }

  Future<bool> deleteHoraFixo(String id) async {
    return await _provider.deleteHoraFixo(id);
  }
}
