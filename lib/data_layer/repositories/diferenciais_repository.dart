import 'package:marcahoras3/data_layer/mappers/diferenciais_mapper.dart';
import 'package:marcahoras3/utils/uuid_factory.dart';

import '../../domain_layer/contracts.dart';
import '../../domain_layer/models/diferenciais.dart';

class DiferenciaisRepository {
  final DiferenciaisProviderContract _provider, _sqlProvider;

  DiferenciaisRepository({
    required DiferenciaisProviderContract provider,
    required DiferenciaisProviderContract sqlProvider,
  }) : _provider = provider,
       _sqlProvider = sqlProvider;

  Future<Diferenciais?> saveDiferencial(Diferenciais diferencial) async {
    final newId = UuidFactory.build();
    final result = await _provider.insertDiferencial(diferencial.toDto(newId));
    final newDif = await _sqlProvider.insertDiferencial(result);

    return Diferenciais.fromDTO(newDif);
  }

  Future<Diferenciais?> updateDiferencial(Diferenciais diferencial) async {
    final result = await _provider.updateDiferencial(diferencial.toDto());
    final updatedDif = await _sqlProvider.updateDiferencial(result);
    return Diferenciais.fromDTO(updatedDif);
  }

  Future<bool> deleteDiferencial(String id) async {
    await _provider.deleteDiferencial(id);
    await _sqlProvider.deleteDiferencial(id);
    return true;
  }

  Future<void> insertMany(List<Diferenciais> difList) async {
    final dl = difList.map((d) => d.toDto()).toList();
    await _provider.insertMany(dl);
    await _sqlProvider.insertMany(dl);
  }
}
