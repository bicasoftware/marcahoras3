import 'package:equatable/equatable.dart';

class AuthenticationDataDto extends Equatable {
  final String accessToken;
  final String refreshToken;

  const AuthenticationDataDto({
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object> get props => [accessToken, refreshToken];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory AuthenticationDataDto.fromJson(Map<String, dynamic> json) {
    return AuthenticationDataDto(
      accessToken: (json['access_token'] ?? '') as String,
      refreshToken: (json['refresh_token'] ?? '') as String,
    );
  }
}
