import 'package:marcahoras3/data_layer/dtos/authentication_data_dto.dart';
import 'package:marcahoras3/domain_layer/contracts/register_contract.dart';

import '../providers.dart';

class RegistrationRepository implements RegisterContract {
  final RegistrationProvider _provider;

  const RegistrationRepository({
    required RegistrationProvider provider,
  }) : _provider = provider;

  @override
  Future<AuthenticationDataDto> login(String email, String password) async {
    final data = await _provider.login(
      email: email,
      password: password,
    );

    return data;
  }

  @override
  Future<AuthenticationDataDto> register(String email, String password) async {
    final data = await _provider.register(
      email: email,
      password: password,
    );

    return data;
  }
}
