import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/forgot_password_bloc/forgot_password_event.dart';
import 'package:tomatebnb/bloc/forgot_password_bloc/forgot_password_state.dart';
import 'package:tomatebnb/repository/auth_repository.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState>{
  final AuthRepository authRepository;
  ForgotPasswordBloc(this.authRepository) : super(ForgotPasswordInitial()){
    on<ForgotPasswordSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(ForgotPasswordSubmitted event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());
    try {
      // Aquí llamas a tu repositorio para enviar el email
      final response = await authRepository.sendResetLink(event.email);
      if (response.status) {
        emit(ForgotPasswordSuccess(response.message));
      } else {
        emit(ForgotPasswordFailure(response.message));
      }
    } catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }
}