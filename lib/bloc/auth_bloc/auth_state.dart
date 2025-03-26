import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/auth/login_response_model.dart';
import 'package:tomatebnb/models/user/user_response_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

// Estados para Inicio de Sesión
class AuthLoading extends AuthState {}
class AuthLoginSuccess extends AuthState {
  final LoginResponseModel responseAuth;
  AuthLoginSuccess(
    this.responseAuth
  );
  @override
  List<Object> get props => [responseAuth];
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
class AuthCreateLoading extends AuthState {}

class AuthCreateSuccess extends AuthState {
  final UserResponseModel responseAuth;
  AuthCreateSuccess(
    this.responseAuth
  );
  @override
  List<Object> get props => [responseAuth];
}

class AuthCreateError extends AuthState {
  final String message;
  AuthCreateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}