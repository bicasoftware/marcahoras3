import '../../../data_layer/dtos.dart';

abstract class DiferenciaisProviderContract {
  Future<DiferenciaisDTO> insertDiferencial(DiferenciaisDTO diferencial);
  Future<DiferenciaisDTO> updateDiferencial(DiferenciaisDTO diferencial);
  Future<bool> deleteDiferencial(String id);
}
