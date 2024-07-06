import '../../../utils/utils.dart';
import '../../../utils/vault/vault_keys.dart';

class LoadVaultDataUseCase {
  const LoadVaultDataUseCase();

  Future<Vault> call() async {
    final vault = VaultManager();
    final token = await vault.readValue(VaultKeys.accessToken);
    final refreshToken = await vault.readValue(VaultKeys.refreshToken);

    return Vault(
      token: token,
      refreshToken: refreshToken,
    );
  }
}
