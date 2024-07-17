import '../../../utils/utils.dart';
import '../../../utils/vault/vault_keys.dart';

class SetVaultDataUsecase {
  const SetVaultDataUsecase();

  Future<void> call({
    required String accessToken,
    required String refreshToken,
  }) async {
    final vaultMan = VaultManager();
    await vaultMan.addValue(VaultKeys.accessToken, accessToken);
    await vaultMan.addValue(VaultKeys.refreshToken, refreshToken);

    final vault = Vault();
    vault.setVaultData(token: accessToken, refreshToken: refreshToken);
  }
}
