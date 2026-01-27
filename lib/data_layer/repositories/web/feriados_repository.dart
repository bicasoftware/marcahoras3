import '../../../domain_layer/models.dart';
import '../../mappers.dart';
import '../../providers.dart';

class FeriadosRepository {
  final FeriadosProvider _provider;

  FeriadosRepository({required FeriadosProvider provider})
    : _provider = provider;

  Future<List<Feriados>> getFeriasByYear(int year) async {
    final feriadosList = await _provider.fetchFeriados(year);

    return feriadosList.map((f) => f.toFeriado()).toList();
  }
}
