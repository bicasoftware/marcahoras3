import '../../domain_layer/models.dart';

abstract class EmpregosContract {
  Future<List<Empregos>> listByVigencia({required int year, required int month});
  Future<Empregos> create(Empregos e);
  Future<Empregos> update(Empregos e);
  Future<void> delete(String empregoId);
}
