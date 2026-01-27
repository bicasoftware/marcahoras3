import '../dtos.dart';

abstract class HorasProviderContract {
  Future<List<HorasDto>> list(String empregoId, String from, String to);
  Future<HorasDto> create(HorasDto hora);
  Future<HorasDto> update(HorasDto hora);
  Future<bool> delete(String horaId);
}
