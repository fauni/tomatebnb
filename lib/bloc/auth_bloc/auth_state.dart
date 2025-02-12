import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/login_response_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final LoginResponse loginResponse;

  AuthSuccess({
    required this.loginResponse,
  });

  @override
  List<Object?> get props => [loginResponse];
}