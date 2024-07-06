import 'package:equatable/equatable.dart';

class RegisterUser extends Equatable {
  final String email;
  final String password;

  const RegisterUser({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory RegisterUser.fromJsonMap(Map<String, dynamic> json) {
    return RegisterUser(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  @override
  bool get stringify => true;
}
