import '../../../utils/utils.dart';

class LoadVaultDataUseCase {
  LoadVaultDataUseCase();

  Future<Vault> call() async {
    final vault = VaultManager();
    final token = await vault.readValue('token');
    final refreshToken = await vault.readValue('refresh_token');

    return Vault(
      token: token,
      refreshToken: refreshToken,
    );
  }
}
