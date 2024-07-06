import '../../../data_layer/dtos.dart';
import '../../../data_layer/respositories.dart';

class LoginUserUsecase {
  final RegistrationRepository _repo;

  const LoginUserUsecase({
    required RegistrationRepository repo,
  }) : _repo = repo;

  Future<AuthenticationDataDto> call({
    required String email,
    required String password,
  }) =>
      _repo.login(email, password);
}
