import 'package:marcahoras3/utils/uuid_factory.dart';

import '../../domain_layer/contracts.dart';
import '../../domain_layer/models/hora_fixo.dart';
import '../mappers/hora_fixo_mapper.dart';

class HoraFixoRepository {
  final HoraFixoProviderContract _provider, _sqlProvider;

  HoraFixoRepository({
    required HoraFixoProviderContract provider,
    required HoraFixoProviderContract sqlProvider,
  }) : _provider = provider,
       _sqlProvider = sqlProvider;

  Future<HoraFixo?> saveHoraFixo(HoraFixo horaFixo) async {
    final newId = UuidFactory.build();
    final dto = horaFixo.toDto(newId);
    final result = await _provider.insertHoraFixo(dto);
    final fixo = await _sqlProvider.insertHoraFixo(result);
    return fixo.toModel();
  }

  Future<HoraFixo?> updateHoraFixo(HoraFixo horaFixo) async {
    final result = await _provider.updateHoraFixo(horaFixo.toDto());
    final updatedFixo = await _sqlProvider.updateHoraFixo(result);
    return updatedFixo.toModel();
  }

  Future<bool> deleteHoraFixo(String id) async {
    await _provider.deleteHoraFixo(id);
    await _sqlProvider.deleteHoraFixo(id);
    return true;
  }
}
