import '../../domain_layer/contracts.dart';
import '../../domain_layer/models/diferenciais.dart';

class DiferenciaisRepository {
  final DiferenciaisProviderContract _provider;

  DiferenciaisRepository({required DiferenciaisProviderContract provider})
    : _provider = provider;

  Future<Diferenciais?> saveDiferencial(Diferenciais diferencial) async {
    final data = await _provider.insertDiferencial(diferencial.toDTO());
    return Diferenciais.fromDTO(data);
  }

  Future<Diferenciais?> updateDiferencial(Diferenciais diferencial) async {
    final data = await _provider.updateDiferencial(diferencial.toDTO());
    return Diferenciais.fromDTO(data);
  }

  Future<bool> deleteDiferencial(String id) async {
    return await _provider.deleteDiferencial(id);
  }
}
