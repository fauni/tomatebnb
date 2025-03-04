import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()){
   on<UserGetByIdEvent>(_onUserGetById);
   on<UserUpdateEvent>(_onUserUpdate); 
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


}

