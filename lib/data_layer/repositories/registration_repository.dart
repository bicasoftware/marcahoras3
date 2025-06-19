import '../../domain_layer/contracts.dart';
import '../../utils.dart';
import '../dtos.dart';
import '../providers.dart';

class RegistrationRepository implements RegisterContract {
  final RegistrationProvider _provider;

  const RegistrationRepository({
    required RegistrationProvider provider,
  }) : _provider = provider;

  @override
  Future<AuthenticationDataDto> login(String email, String password) async {
    return await _provider.login(
      email: email,
      password: password,
    );
  }

  @override
  Future<AuthenticationDataDto> register(String email, String password) async {
    return await _provider.register(
      email: email,
      password: password,
    );
  }

  @override
  Future<bool> refresh() async {
    final vault = Vault();
    if (!(vault.isLoggedIn && vault.hasRefreshToken)) return false;

    /// Calls the [RegistrationProvider] and awaits
    final result = await _provider.refreshToken();

    await VaultManager.refreshVault(
      accessToken: result.accessToken,
      refreshToken: result.refreshToken,
    );

    return true;
  }
}
