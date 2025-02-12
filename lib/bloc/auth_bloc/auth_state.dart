import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/auth/login_response_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

// Estados para Inicio de Sesión
class AuthLoading extends AuthState {}
class AuthLoginSuccess extends AuthState {
  final LoginResponseModel responseUser;
  AuthLoginSuccess(
    this.responseUser
  );
  @override
  List<Object> get props => [responseUser];
}

class AuthLoginError extends AuthState {
  final String message;
  AuthLoginError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

// Estado para cerrar sesion
class AuthLogoutSuccess extends AuthState {}

// Estados para registrar Usuario