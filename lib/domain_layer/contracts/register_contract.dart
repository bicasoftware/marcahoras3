import '../../data_layer/dtos.dart';

abstract class RegisterContract {
  Future<AuthenticationDataDto> register(String email, String password);
  Future<AuthenticationDataDto> login(String email, String password);
}
