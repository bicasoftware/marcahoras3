import '../dtos.dart';

abstract class HoraFixoProviderContract {
  Future<HoraFixoDto> insertHoraFixo(HoraFixoDto horaFixo);
  Future<HoraFixoDto> updateHoraFixo(HoraFixoDto horaFixo);
  Future<bool> deleteHoraFixo(String id);
}
