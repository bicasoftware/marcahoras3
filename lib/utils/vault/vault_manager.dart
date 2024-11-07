import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:marcahoras3/utils/vault/vault_keys.dart';

import 'vault.dart';

class VaultManager {
  static final VaultManager _vault = VaultManager._internal();
  static late final FlutterSecureStorage _storage;

  factory VaultManager() {
    return _vault;
  }

  VaultManager._internal() {
    _storage = const FlutterSecureStorage();
  }

  Future<void> addValue(String paramName, String value) async {
    return await _storage.write(key: paramName, value: value);
  }

  Future<void> deleteValue(String paramName) async {
    return await _storage.delete(key: paramName);
  }

  Future<String?> readValue<T>(String param) async {
    return await _storage.read(key: param);
  }

  Future<void> cleanAll() {
    return Future.wait([
      deleteValue(VaultKeys.accessToken),
      deleteValue(VaultKeys.refreshToken),
    ]);
  }

  static Future<void> buildVaultData() async {
    final vaultMan = VaultManager();
    final token = await vaultMan.readValue(VaultKeys.accessToken);
    final refreshToken = await vaultMan.readValue(VaultKeys.refreshToken);

    final vault = Vault();
    vault.setVaultData(
      token: token ?? '',
      refreshToken: refreshToken ?? '',
    );
  }
}
