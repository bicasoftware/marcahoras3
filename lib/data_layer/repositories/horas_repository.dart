import '../../domain_layer/contracts.dart';
import '../../domain_layer/models.dart';
import '../../utils.dart';
import '../mappers/horas_mapper.dart';

class HorasRepository implements HorasContract {
  final HorasProviderContract _provider, _sqlProvider;

  HorasRepository({
    required HorasProviderContract provider,
    required HorasProviderContract sqlProvider,
  }) : _provider = provider,
       _sqlProvider = sqlProvider;

  @override
  Future<Horas> create(Horas horas) async {
    final newId = UuidFactory.build();
    final result = await _provider.create(horas.toHorasDto(newId));
    final newHora = await _sqlProvider.create(result);
    return newHora.toHoras();
  }

  @override
  Future<bool> delete(String horaId) async {
    await _provider.delete(horaId);
    await _sqlProvider.delete(horaId);
    return true;
  }

  @override
  Future<List<Horas>> list(String empregoId, String from, String to) async {
    final horas = await _sqlProvider.list(empregoId, from, to);
    return horas.map((h) => h.toHoras()).toList();
  }

  @override
  Future<Horas> update(Horas horas) async {
    final result = await _provider.update(horas.toHorasDto());
    final hora = await _sqlProvider.update(result);
    return hora.toHoras();
  }
}
