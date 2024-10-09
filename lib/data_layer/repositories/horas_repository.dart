import '../../domain_layer/models.dart';
import '../mappers/horas_mapper.dart';

import '../../domain_layer/contracts.dart';
import '../providers.dart';

class HorasRepository implements HorasContract {
  final HorasProvider _provider;

  HorasRepository({
    required HorasProvider provider,
  }) : _provider = provider;

  @override
  Future<Horas> create(Horas horas) async {
    final result = await _provider.create(horas.toHorasDto());
    return result.toHoras();
  }

  @override
  Future<bool> delete(String horaId) async {
    return await _provider.delete(horaId);
  }

  @override
  Future<Horas> findOne(String horaId) async {
    final hora = await _provider.findOne(horaId);
    return hora.toHoras();
  }

  @override
  Future<List<Horas>> list(String empregoId, String from, String to) async {
    final horas = await _provider.list(empregoId, from, to);
    return horas.map((h) => h.toHoras()).toList();
  }

  @override
  Future<Horas> update(Horas horas) async {
    final hora = await _provider.update(horas.toHorasDto());
    return hora.toHoras();
  }
}
