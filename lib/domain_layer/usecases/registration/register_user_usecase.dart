import '../../../data_layer/dtos.dart';
import '../../../data_layer/respositories.dart';

class RegisterUserUsecase {
  final RegistrationRepository _repo;

  RegisterUserUsecase({
    required RegistrationRepository repo,
  }) : _repo = repo;

  Future<AuthenticationDataDto> call({
    required String email,
    required String password,
  }) =>
      _repo.register(email, password);
}
