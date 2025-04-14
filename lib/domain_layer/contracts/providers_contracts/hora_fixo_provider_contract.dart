import '../../../data_layer/dtos.dart';

abstract class HoraFixoProviderContract {
  Future<HoraFixoDTO> insertHoraFixo(HoraFixoDTO horaFixo);
  Future<HoraFixoDTO> updateHoraFixo(HoraFixoDTO horaFixo);
  Future<bool> deleteHoraFixo(String id);
}
