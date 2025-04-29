import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/reserve_respository.dart';

class ReserveBloc extends Bloc<ReserveEvent, ReserveState> {
  final ReserveRepository reserveRepository;

  ReserveBloc(this.reserveRepository) : super(ReserveInitial()){
    on<ReserveCreateEvent>(_onReserveCreate);
    on<ReserveGetByUserEvent>(_onReserveGetByUser);
    on<ReserveGetByIdEvent>(_onReserveGetById);
    on<ReserveCheckinEvent>(_onReserveCheckin);
    on<ReserveCheckoutEvent>(_onReserveCheckout);
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

    Future<void> _onReserveCheckin(ReserveCheckinEvent event, Emitter<ReserveState> emit) async {
    emit(ReserveCheckinLoading());
    try{
      final response = await reserveRepository.check(event.id, event.dateCheckin, 'checkin_date');
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(ReserveCheckinSuccess(response.status));
      } else {
        emit(ReserveCheckinError(response.message));
      }
    } catch(e){
      emit(ReserveCheckinError(e.toString()));
    }
  }

   Future<void> _onReserveCheckout(ReserveCheckoutEvent event, Emitter<ReserveState> emit) async {
    emit(ReserveCheckoutLoading());
    try{
      final response = await reserveRepository.check(event.id, event.dateCheckout, 'checkout_date');
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(ReserveCheckoutSuccess(response.status));
      } else {
        emit(ReserveCheckoutError(response.message));
      }
    } catch(e){
      emit(ReserveCheckoutError(e.toString()));
    }
  }

}