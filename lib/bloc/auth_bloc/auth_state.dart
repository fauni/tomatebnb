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

// Estados para registrar Codigo de verificación
class VerificationCodeCreateLoading extends AuthState {}

class VerificationCodeCreateSuccess extends AuthState {
  final bool status;
  VerificationCodeCreateSuccess(
    this.status
  );
  @override
  List<Object> get props => [status];
}

class VerificationCodeCreateError extends AuthState {
  final String message;
  VerificationCodeCreateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

// Estados para  verificar el codigo de verificación
class VerificateLoading extends AuthState {}

class VerificateSuccess extends AuthState {
  final bool status;
  VerificateSuccess(
    this.status
  );
  @override
  List<Object> get props => [status];
}

class VerificateError extends AuthState {
  final String message;
  VerificateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}