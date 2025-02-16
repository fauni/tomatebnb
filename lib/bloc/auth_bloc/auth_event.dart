import 'package:equatable/equatable.dart';
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;
  AuthLoginEvent(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

class AuthLogoutEvet extends AuthEvent {}

class RegistrarUsuarioEvent extends AuthEvent {
  final String usuario;
  final String email;
  final String password;

  RegistrarUsuarioEvent({required this.usuario, required this.email, required this.password});
  @override
  
  List<Object?> get props => [usuario, email, password];
}
