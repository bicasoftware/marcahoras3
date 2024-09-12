import '../models.dart';

abstract class HorasContract {
  Future<List<Horas>> list(String empregoId);
  Future<Horas> findOne(String horaId);
  Future<Horas> create(Horas horas);
  Future<Horas> update(Horas horas);
  Future<bool> delete(String horaId);
}
