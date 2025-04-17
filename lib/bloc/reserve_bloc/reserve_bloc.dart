import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/reserve_respository.dart';

class ReserveBloc extends Bloc<ReserveEvent, ReserveState> {
  final ReserveRepository reserveRepository;

  ReserveBloc(this.reserveRepository) : super(ReserveInitial()){
    on<ReserveCreateEvent>(_onReserveCreate);
    on<ReserveGetByUserEvent>(_onReserveGetByUser);
    on<ReserveGetByIdEvent>(_onReserveGetById);
  }

  Future<void> _onReserveCreate(ReserveCreateEvent event, Emitter<ReserveState> emit) async {
    emit(ReserveCreateLoading());
    try{
      final response = await reserveRepository.createReserve(event.requestModel);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(ReserveCreateSuccess(response.data!));
      } else {
        emit(ReserveCreateError(response.message));
      }
    } catch(e){
      emit(ReserveCreateError(e.toString()));
      
    }
  }

  Future<void> _onReserveGetByUser(ReserveGetByUserEvent event, Emitter<ReserveState> emit) async {
    emit(ReserveGetByUserLoading());
    try{
      final response = await reserveRepository.getByUser();
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(ReserveGetByUserSuccess(response.data!));
      } else {
        emit(ReserveGetByUserError(response.message));
      }
    } catch(e){
      emit(ReserveGetByUserError(e.toString()));
    }
  }

  Future<void> _onReserveGetById(ReserveGetByIdEvent event, Emitter<ReserveState> emit) async {
    emit(ReserveGetByIdLoading());
    try{
      final response = await reserveRepository.getReserveById(event.id);
      if(response.status){
        emit(ReserveGetByIdSuccess(response.data!));
      } else {
        emit(ReserveGetByIdError(response.message));
      }
    } catch(e){
      emit(ReserveGetByIdError(e.toString()));
    }
  }
}