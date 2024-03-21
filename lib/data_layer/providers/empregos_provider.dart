import 'package:supabase_flutter/supabase_flutter.dart';

import '../dtos.dart';

class EmpregosProvider {
  final SupabaseClient _supa;
  static const String _table = 'empregos';

  EmpregosProvider(
    SupabaseClient client,
  ) : _supa = client;

  Future<List<EmpregosDTO>> list() async {
    final result = await _supa.from(_table).select(
          '*, salarios(*), horas(*)',
        );

    return EmpregosDTO.fromJsonList(result).toList();
  }

  Future<EmpregosDTO> append(EmpregosDTO e) async {
    final result = await _supa.from(_table).insert(e.toJson()).select();
    return EmpregosDTO.fromJson(result.first);
  }

  Future<void> delete(int empregoId) async {
    await _supa.from(_table).delete().match({'id': empregoId}).select();
  }
}
