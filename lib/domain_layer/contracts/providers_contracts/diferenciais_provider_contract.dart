import '../../../data_layer/dtos.dart';

abstract class DiferenciaisProviderContract {
  Future<DiferenciaisDto> insertDiferencial(DiferenciaisDto diferencial);
  Future<DiferenciaisDto> updateDiferencial(DiferenciaisDto diferencial);
  Future<bool> deleteDiferencial(String id);
}
