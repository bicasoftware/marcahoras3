import '../mappers/horas_mapper.dart';
import '../tables/realm_models.dart';
import 'package:realm/realm.dart';

import '../../domain_layer/contracts.dart';
import '../../utils/utils.dart';
import '../dtos/horas_dto.dart';

class HorasDbProvider implements HorasProviderContract {
  final Realm _realm;

  const HorasDbProvider({required Realm realm}) : _realm = realm;

  @override
  Future<HorasDto> create(HorasDto hora) async {
    final emprego = _realm.find<EmpregosRealm>(hora.empregoId);
    if (emprego != null) {
      await _realm.writeAsync(
        () {
          emprego.horas.add(hora.toRealm());
        },
      );

      return hora;
    }

    throw ResourceNotFound('resource not found');
  }

  @override
  Future<bool> delete(String horaId) async {
    final h = _realm.find<HorasRealm>(horaId);
    if (h != null) {
      await _realm.writeAsync(() => _realm.delete(h));
      return true;
    }

    return false;
  }

  @override
  Future<HorasDto> findOne(String horaId) async {
    final h = _realm.find<HorasRealm>(horaId);
    if (h != null) {
      return h.toDto();
    }

    throw ResourceNotFound("resource not found");
  }

  @override
  Future<List<HorasDto>> list(String empregoId, String from, String to) async {
    final e = _realm.find<EmpregosRealm>(empregoId);
    if (e != null) {
      final begin = parseDate(from);
      final end = parseDate(to);
      return e.horas
          .where((h) => h.data != null)
          .where(
            (h) =>
                h.data!.isSameDayOrAfter(begin!) &&
                h.data!.isSameDayOfBefore(end!),
          )
          .map((h) => h.toDto())
          .toList();
    }

    throw ResourceNotFound("resource not found");
  }

  @override
  Future<HorasDto> update(HorasDto hora) async {
    final result = _realm.find<HorasRealm>(hora.id);
    if (result != null) {
      await _realm.writeAsync(() => result.updateFromDto(hora));
      return hora;
    }

    throw ResourceNotFound("resource not found");
  }
}
