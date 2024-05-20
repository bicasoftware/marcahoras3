class Vault {
  String? token;
  String? refreshToken;

  Vault({
    this.token,
    this.refreshToken,
  });

  bool get hasToken => token?.isNotEmpty == true;
}
