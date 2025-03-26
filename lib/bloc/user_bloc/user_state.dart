import 'package:equatable/equatable.dart';

import 'package:tomatebnb/models/user/user_response_model.dart';


abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

//Estados para obtencion de usuario por id
class UserGetByIdLoading extends UserState {}

class UserGetByIdSuccess extends UserState {
  final UserResponseModel responseUser;
  UserGetByIdSuccess(
    this.responseUser
  );
  @override
  List<Object> get props => [responseUser];
}

class UserGetByIdError extends UserState {
  final String message;
  UserGetByIdError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//Estados para actualizar alojamiento por id
class UserUpdateLoading extends UserState {}

class UserUpdateSuccess extends UserState {
  final bool status;
  UserUpdateSuccess(
    this.status
  );
  @override
  List<Object> get props => [status];
}

class UserUpdateError extends UserState {
  final String message;
  UserUpdateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//estados para crear foto de usuario ya se perfil o de documentos
class UserPhotoUpdateLoading extends UserState {}

class UserPhotoUpdateSuccess extends UserState {
  final UserResponseModel responseUserPhoto;
  UserPhotoUpdateSuccess(
    this.responseUserPhoto
  );
  @override
  List<Object> get props => [responseUserPhoto];
}

class UserPhotoUpdateError extends UserState {
  final String message;
  UserPhotoUpdateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//Estados para actualizar contraseña por id
class UserPasswordUpdateLoading extends UserState {}

class UserPasswordUpdateSuccess extends UserState {
  final bool status;
  UserPasswordUpdateSuccess(
    this.status
  );
  @override
  List<Object> get props => [status];
}

class UserPasswordUpdateError extends UserState {
  final String message;
  UserPasswordUpdateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}


