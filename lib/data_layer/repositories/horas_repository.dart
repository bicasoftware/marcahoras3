import '../../domain_layer/contracts.dart';
import '../../domain_layer/models.dart';
import '../../utils.dart';
import '../mappers/horas_mapper.dart';

class HorasRepository implements HorasContract {
  final HorasProviderContract _provider;

  HorasRepository({
    required HorasProviderContract provider,
  }) : _provider = provider;

  @override
  Future<Horas> create(Horas horas) async {
    final newId = UuidFactory.build();
    final dto = horas.toHorasDto(newId);
    final newHora = await _provider.create(dto);
    return newHora.toHoras();
  }

  @override
  Future<bool> delete(String horaId) async {
    await _provider.delete(horaId);
    return true;
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
