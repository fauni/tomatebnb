import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()){
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthLogoutEvet>(_onAuthLogout);
    on<AuthCreateEvent>(_onAuthCreate);
  }

  Future<void> _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try{
      final response = await authRepository.login(event.email, event.password);
      if(response.status){
        await authRepository.setUserData(response.data!);
        emit(AuthLoginSuccess(response.data!));
      } else {
        emit(AuthLoginError(response.message));
      }
    } catch(e){
      emit(AuthLoginError(e.toString()));
    }
  }

  Future<void> _onAuthCreate(AuthCreateEvent event, Emitter<AuthState> emit) async {
    emit(AuthCreateLoading());
    try{
      final response = await authRepository.create(event.userRequest) ;
      if(response.status){
        // await authRepository.setUserData(response.data!);
        emit(AuthCreateSuccess(response.data!));
      } else {
        emit(AuthCreateError(response.message));
      }
    } catch(e){
      emit(AuthCreateError(e.toString()));
    }
  }

  Future<void> _onAuthLogout(AuthLogoutEvet event, Emitter<AuthState> emit) async {
    await authRepository.clearUsarData();
    emit(AuthLogoutSuccess());
  }
}