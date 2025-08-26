import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/user/user_request_modelp.dart';
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

// ignore: must_be_immutable
class AuthCreateEvent extends AuthEvent {

  final UserRequestModelp userRequest;
  AuthCreateEvent(this.userRequest);
  @override
  List<Object?> get props => [userRequest];
}

class VerificationCodeCreateEvent extends AuthEvent {
  final String email;
  VerificationCodeCreateEvent(this.email);
  @override
  List<Object?> get props => [email];
}

class VerificateEvent extends AuthEvent {
  final String code;
  final String email;
  VerificateEvent(this.code,this.email);
  @override
  List<Object?> get props => [code,email];
}

