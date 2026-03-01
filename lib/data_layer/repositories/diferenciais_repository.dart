import '../../domain_layer/models/diferenciais.dart';
import '../../utils/uuid_factory.dart';
import '../contracts.dart';
import '../mappers/diferenciais_mapper.dart';

class DiferenciaisRepository {
  final DiferenciaisProviderContract _provider;

  DiferenciaisRepository({
    required DiferenciaisProviderContract provider,
  }) : _provider = provider;

  Future<Diferenciais?> saveDiferencial(Diferenciais diferencial) async {
    final newDif = await _provider.insertDiferencial(
      diferencial.toDto(generateId()),
    );
    return Diferenciais.fromDTO(newDif);
  }

  Future<Diferenciais?> updateDiferencial(Diferenciais diferencial) async {
    final updatedDif = await _provider.updateDiferencial(diferencial.toDto());
    return Diferenciais.fromDTO(updatedDif);
  }

  Future<bool> deleteDiferencial(String id) async {
    await _provider.deleteDiferencial(id);
    return true;
  }

  Future<void> insertMany(List<Diferenciais> difList) async {
    final dl = difList.map((d) => d.toDto()).toList();
    await _provider.insertMany(dl);
  }

  Future<void> deleteMany(String empregoId) async {
    await _provider.deleteMany(empregoId);
  }
}
