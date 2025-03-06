import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()){
   on<UserGetByIdEvent>(_onUserGetById);
   on<UserUpdateEvent>(_onUserUpdate); 
   on<UserPhotoUpdateEvent>(_onUserPhotoUpdate); 
  }

  Future<void> _onUserGetById(UserGetByIdEvent event, Emitter<UserState> emit) async {
    emit(UserGetByIdLoading());
    try{
      final response = await userRepository.getUser();
      if(response.status){
        //await userRepository.setUserData(response.data!);
        emit(UserGetByIdSuccess(response.data!));
      } else {
        emit(UserGetByIdError(response.message));
      }
    } catch(e){
      emit(UserGetByIdError(e.toString()));
    }
  }

 Future<void> _onUserUpdate(UserUpdateEvent event, Emitter<UserState> emit) async {
    emit(UserUpdateLoading());
    try{
      final response = await userRepository.update(event.userRequest);
      if(response.status){
        //await userRepository.setUserData(response.data!);
        emit(UserUpdateSuccess(response.status));
      } else {
        emit(UserUpdateError(response.message));
      }
    } catch(e){
      emit(UserUpdateError(e.toString()));
    }
  }

  Future<void> _onUserPhotoUpdate(UserPhotoUpdateEvent event, Emitter<UserState> emit) async {
    emit(UserPhotoUpdateLoading());
    try{
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: event.camera
                                                           ?ImageSource.camera
                                                           :ImageSource.gallery);
      File file = File(image!.path);                                                           
      final response = await userRepository.updateUserPhoto(event.column, file);
      
      if(response.status){
        await userRepository.setUserData(response.data!);
        emit(UserPhotoUpdateSuccess(response.data!));
      } else {
        emit(UserPhotoUpdateError(response.message));
      }
    } catch(e){
      emit(UserPhotoUpdateError(e.toString()));
      
    }
  }

}

