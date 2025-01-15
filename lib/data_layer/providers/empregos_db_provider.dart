import 'package:realm/realm.dart';

import '../../domain_layer/contracts.dart';
import '../../utils/utils.dart';
import '../dtos/empregos_dto.dart';
import '../mappers.dart';
import '../tables/realm_models.dart';

class EmpregosDbProvider implements EmpregosProviderContract {
  final Realm _realm;

  const EmpregosDbProvider({required Realm realm}) : _realm = realm;

  @override
  Future<EmpregosDto> append(EmpregosDto e) async {
    final emprego = await _realm.writeAsync<EmpregosRealm>(
      () {
        return _realm.add(e.toRealm());
      },
    );

    return emprego.toDto();
  }

  @override
  Future<void> delete(String empregoId) async {
    final emprego = _realm.find<EmpregosRealm>(empregoId);
    if (emprego != null) {
      return _realm.writeAsync(() {
        _realm.delete<EmpregosRealm>(emprego);
      });
    }
  }

  @override
  Future<List<EmpregosDto>> list(String from, String to) async {
    final begin = parseDate(from);
    final end = parseDate(to);

    final empregosList = <EmpregosDto>[];
    final empregos = _realm.all<EmpregosRealm>();

    empregos.forEach((e) {
      final horas = e.horas.where((h) => h.data != null).where(
            (h) =>
                h.data!.isSameDayOrAfter(begin!) &&
                h.data!.isSameDayOfBefore(end!),
          );
      var empregoDto = e.toDto(false);
      empregoDto = empregoDto.copyWith(
        horas: horas.map((h) => h.toDto()).toList(),
        salarios: e.salarios.map((s) => s.toDto()).toList(),
      );
      empregosList.add(empregoDto);
    });

    return empregosList;
  }

  @override
  Future<EmpregosDto> update(EmpregosDto emprego) async {
    final e = _realm.find<EmpregosRealm>(emprego.id);
    if (e != null) {
      await _realm.writeAsync(() {
        e.updateFromDto(emprego);
      });

      return emprego;
    }

    throw ResourceNotFound("resource not found");
  }
}
