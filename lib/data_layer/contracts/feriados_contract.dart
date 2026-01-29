import '../dtos.dart';

abstract class FeriadosContract {
  Future<List<AnosDto>> fetchAnos();
}
