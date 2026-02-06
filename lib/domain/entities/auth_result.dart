class AuthResult {
  final String accessToken;
  final String refreshToken;
  final Map<String, dynamic> user;

  AuthResult({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  AuthResult copyWith({
    String? accessToken,
    String? refreshToken,
    Map<String, dynamic>? user,
  }) {
    return AuthResult(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
    );
  }
}
