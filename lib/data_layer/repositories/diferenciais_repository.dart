import '../../domain_layer/contracts.dart';
import '../../domain_layer/models/diferencial.dart';

class DiferenciaisRepository {
  final DiferenciaisProviderContract _provider;

  DiferenciaisRepository({required DiferenciaisProviderContract provider})
    : _provider = provider;

  Future<Diferencial> saveDiferencial(Diferencial diferencial) async {
    final data = await _provider.insertDiferencial(diferencial.toDTO());
    return Diferencial.fromDTO(data);
  }

  Future<Diferencial> updateDiferencial(Diferencial diferencial) async {
    final data = await _provider.updateDiferencial(diferencial.toDTO());
    return Diferencial.fromDTO(data);
  }

  Future<bool> deleteDiferencial(String id) async {
    return await _provider.deleteDiferencial(id);
  }
}
