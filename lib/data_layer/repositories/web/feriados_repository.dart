import 'package:marcahoras3/data_layer/mappers.dart';

import '../../../domain_layer/models.dart';
import '../../providers.dart';

class FeriadosRepository {
  final FeriadosProvider _provider;

  FeriadosRepository({required FeriadosProvider provider})
    : _provider = provider;

  Future<List<Anos>> getFeriados() async {
    final anosList = await _provider.fetchAnos();
    return anosList.map((a) => a.toAno()).toList();
  }
}
