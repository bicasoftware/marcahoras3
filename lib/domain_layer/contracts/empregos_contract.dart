import '../models.dart';

abstract class EmpregosContract {
  Future<List<Empregos>> list();
  Future<Empregos> append(Empregos e);
  Future<void> delete(int empregoId);
}