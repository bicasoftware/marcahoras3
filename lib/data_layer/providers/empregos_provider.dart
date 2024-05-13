import 'package:marcahoras3/data_layer/mappers/emprego_mapper.dart';
import 'package:marcahoras3/data_layer/realm_models/empregos_realm.dart';
import 'package:realm/realm.dart';

import '../dtos.dart';

class EmpregosProvider {
  final Realm _realm;

  const EmpregosProvider({
    required Realm realm,
  }) : _realm = realm;

  Future<List<EmpregosDTO>> list() async {
    final empregos = _realm.all<EmpregosRealm>();
    if (empregos.isNotEmpty) {
      return empregos.map((e) => e.toEmpregosDto()).toList();
    }

    return [];

    // TODO - aplicar WebClient e ler dados do server*
  }

  Future<EmpregosDTO> append(EmpregosDTO e) async {
    final result = _realm.write<EmpregosRealm>(() {
      return _realm.add(e.toRealmModel());
    });

    return result.toEmpregosDto();

    // TODO - aplicar WebClient e ler dados do server
  }

  Future<void> delete(String empregoId) async {
    final emprego = _realm.find<EmpregosRealm>(empregoId);

    if (emprego == null) {
      throw Exception("Local ID not found");
    }

    try {
      _realm.delete<EmpregosRealm>(emprego);
    } catch (e) {
      throw Exception("Failed to delete: $e");
    }

    // TODO - aplicar WebClient e deletar no server
  }
}
