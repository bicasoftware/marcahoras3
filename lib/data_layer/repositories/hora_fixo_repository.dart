import 'package:marcahoras3/utils/uuid_factory.dart';

import '../contracts.dart';
import '../../domain_layer/models/hora_fixo.dart';
import '../mappers/hora_fixo_mapper.dart';

class HoraFixoRepository {
  final HoraFixoProviderContract _provider;

  HoraFixoRepository({
    required HoraFixoProviderContract provider,
  }) : _provider = provider;

  Future<HoraFixo?> saveHoraFixo(HoraFixo horaFixo) async {
    final newId = UuidFactory.build();
    final dto = horaFixo.toDto(newId);
    final fixo = await _provider.insertHoraFixo(dto);
    return fixo.toModel();
  }

  Future<HoraFixo?> updateHoraFixo(HoraFixo horaFixo) async {
    final updatedFixo = await _provider.updateHoraFixo(horaFixo.toDto());
    return updatedFixo.toModel();
  }

  Future<bool> deleteHoraFixo(String id) async {
    await _provider.deleteHoraFixo(id);
    return true;
  }
}
