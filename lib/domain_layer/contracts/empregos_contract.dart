import '../models.dart';

abstract class EmpregosContract {
  Future<List<Empregos>> list(String from, String to);
  Future<Empregos> create(Empregos e);
  Future<Empregos> update(Empregos e);
  Future<void> delete(String empregoId);
}
