import 'package:equatable/equatable.dart';

/// Model that represents a user to be sent to server
class Usuario extends Equatable {
  final String email;
  final String password;

  const Usuario({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
