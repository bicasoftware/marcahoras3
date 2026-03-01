import '../dtos.dart';

abstract class DiferenciaisProviderContract {
  Future<DiferenciaisDto> insertDiferencial(DiferenciaisDto diferencial);
  Future<List<DiferenciaisDto>> insertMany(List<DiferenciaisDto> difList);
  Future<DiferenciaisDto> updateDiferencial(DiferenciaisDto diferencial);
  Future<bool> deleteDiferencial(String id);
  Future<bool> deleteMany(String empregoId);
}
