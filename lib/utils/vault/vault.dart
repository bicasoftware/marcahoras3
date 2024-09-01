class Vault {
  Vault._();
  static final Vault _instance = Vault._();

  static String _token = '';
  String get token => _token;

  static String _refreshToken = '';
  String get refreshToken => _refreshToken;

  bool get isLoggedIn => token.isNotEmpty;

  void setVaultData({
    required String token,
    required String refreshToken,
  }) {
    _token = token;
    _refreshToken = _refreshToken;
  }

  void clean() {
    
  }

  factory Vault() {
    return _instance;
  }
}
