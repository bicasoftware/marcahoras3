import '../../../utils/utils.dart';
import '../../../utils/vault/vault_keys.dart';

class ResetVaultUseCase {
  const ResetVaultUseCase();

  Future<void> call() async {
    final vaultMan = VaultManager();
    await vaultMan.deleteValue(VaultKeys.accessToken);
    await vaultMan.deleteValue(VaultKeys.refreshToken);

    final vault = Vault();
    vault.setVaultData(token: '', refreshToken: '');
  }
}
