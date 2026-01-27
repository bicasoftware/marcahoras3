import '../dtos.dart';

abstract class FeriadosContract {
  Future<List<FeriadosDto>> fetchFeriados(int year);
  Future<List<FeriadosDto>> insertFeriados(List<FeriadosDto> feriadosList);
}
