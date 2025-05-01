import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/event_repository.dart';


class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository reserveRepository;

  EventBloc(this.reserveRepository) : super(EventInitial()){
    on<EventCreateEvent>(_onEventCreate);
    on<EventGetByReserveEvent>(_onEventGetByReserve);
    // on<EventGetByIdEvent>(_onEventGetById);
    // on<EventCheckinEvent>(_onEventCheckin);
    // on<EventCheckoutEvent>(_onEventCheckout);
  }

  Future<void> _onEventCreate(EventCreateEvent event, Emitter<EventState> emit) async {
    emit(EventCreateLoading());
    try{
      final response = await reserveRepository.createEvent(event.requestModel);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(EventCreateSuccess(response.data!));
      } else {
        emit(EventCreateError(response.message));
      }
    } catch(e){
      emit(EventCreateError(e.toString()));
      
    }
  }

  Future<void> _onEventGetByReserve(EventGetByReserveEvent event, Emitter<EventState> emit) async {
    emit(EventGetByReserveLoading());
    try{
      final response = await reserveRepository.getByReserve(event.reserveId);
      if(response.status){
        //await accommodationRepository.setReserveData(response.data!);
        emit(EventGetByReserveSuccess(response.data!));
      } else {
        emit(EventGetByReserveError(response.message));
      }
    } catch(e){
      emit(EventGetByReserveError(e.toString()));
    }
  }

  // Future<void> _onEventGetById(EventGetByIdEvent event, Emitter<EventState> emit) async {
  //   emit(EventGetByIdLoading());
  //   try{
  //     final response = await reserveRepository.getEventById(event.id);
  //     if(response.status){
  //       emit(EventGetByIdSuccess(response.data!));
  //     } else {
  //       emit(EventGetByIdError(response.message));
  //     }
  //   } catch(e){
  //     emit(EventGetByIdError(e.toString()));
  //   }
  // }

  //   Future<void> _onEventCheckin(EventCheckinEvent event, Emitter<EventState> emit) async {
  //   emit(EventCheckinLoading());
  //   try{
  //     final response = await reserveRepository.check(event.id, event.dateCheckin, 'checkin_date');
  //     if(response.status){
  //       //await accommodationRepository.setUserData(response.data!);
  //       emit(EventCheckinSuccess(response.status));
  //     } else {
  //       emit(EventCheckinError(response.message));
  //     }
  //   } catch(e){
  //     emit(EventCheckinError(e.toString()));
  //   }
  // }

  //  Future<void> _onEventCheckout(EventCheckoutEvent event, Emitter<EventState> emit) async {
  //   emit(EventCheckoutLoading());
  //   try{
  //     final response = await reserveRepository.check(event.id, event.dateCheckout, 'checkout_date');
  //     if(response.status){
  //       //await accommodationRepository.setUserData(response.data!);
  //       emit(EventCheckoutSuccess(response.status));
  //     } else {
  //       emit(EventCheckoutError(response.message));
  //     }
  //   } catch(e){
  //     emit(EventCheckoutError(e.toString()));
  //   }
  // }

}