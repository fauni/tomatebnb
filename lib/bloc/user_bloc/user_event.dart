
import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/user/user_request_model.dart';
abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserGetByIdEvent extends UserEvent {
  
  UserGetByIdEvent();
  @override
  List<Object?> get props => [];
}

class UserUpdateEvent extends UserEvent {
  
  final UserRequestModel userRequest;
  UserUpdateEvent(this.userRequest);
  @override
  List<Object?> get props => [userRequest];
}

class UserPhotoUpdateEvent extends UserEvent {
  
  final bool camera ;
  final String column;
  UserPhotoUpdateEvent(this.camera,this.column);
  @override
  List<Object?> get props => [camera,column];
}

class UserPasswordUpdateEvent extends UserEvent {
  
  final String password;
  UserPasswordUpdateEvent(this.password);
  @override
  List<Object?> get props => [password];
}

class UserUnsubscribeEvent extends UserEvent {
  
  UserUnsubscribeEvent();
  @override
  List<Object?> get props => [];
}
