import '../../../utils/utils.dart';
import '../../../utils/vault/vault_keys.dart';

class SetVaultDataUsecase {
  const SetVaultDataUsecase();

  Future<Vault> call({
    required String accessToken,
    required String refreshToken,
  }) async {
    final vault = VaultManager();
    await vault.addValue(VaultKeys.accessToken, accessToken);
    await vault.addValue(VaultKeys.refreshToken, refreshToken);

    return Vault(
      token: accessToken,
      refreshToken: refreshToken,
    );
  }
}
