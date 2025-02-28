import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/accommodation_repository.dart';

class AccommodationBloc extends Bloc<AccommodationEvent, AccommodationState> {
  final AccommodationRepository accommodationRepository;

  AccommodationBloc(this.accommodationRepository) : super(AccommodationInitial()){
    on<AccommodationGetEvent>(_onAccommodationGet);
    on<AccommodationCreateEvent>(_onAccommodationCreate);
    on<AccommodationGetByIdEvent>(_onAccommodationGetById);
    on<AccommodationUpdateEvent>(_onAccommodationUpdate);
    on<AccommodationUpdate2Event>(_onAccommodationUpdate2);
  }

  Future<void> _onAccommodationGet(AccommodationGetEvent event, Emitter<AccommodationState> emit) async {
    emit(AccommodationLoading());
    try{
      final response = await accommodationRepository.getByUser();
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationGetSuccess(response.data!));
      } else {
        emit(AccommodationGetError(response.message));
      }
    } catch(e){
      emit(AccommodationGetError(e.toString()));
    }
  }

   Future<void> _onAccommodationCreate(AccommodationCreateEvent event, Emitter<AccommodationState> emit) async {
    emit(AccommodationCreateLoading());
    try{
      final response = await accommodationRepository.createAd();
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationCreateSuccess(response.data!));
      } else {
        emit(AccommodationCreateError(response.message));
      }
    } catch(e){
      emit(AccommodationCreateError(e.toString()));
    }
  }

  Future<void> _onAccommodationGetById(AccommodationGetByIdEvent event, Emitter<AccommodationState> emit) async {
    emit(AccommodationGetByIdLoading());
    try{
      final response = await accommodationRepository.getByIdComplete(event.id);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationGetByIdSuccess(response.data!));
      } else {
        emit(AccommodationGetByIdError(response.message));
      }
    } catch(e){
      emit(AccommodationGetByIdError(e.toString()));
    }
  }

 Future<void> _onAccommodationUpdate(AccommodationUpdateEvent event, Emitter<AccommodationState> emit) async {
    emit(AccommodationUpdateLoading());
    try{
      final response = await accommodationRepository.update(event.id,event.accommodationRequest);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationUpdateSuccess(response.status));
      } else {
        emit(AccommodationUpdateError(response.message));
      }
    } catch(e){
      emit(AccommodationUpdateError(e.toString()));
    }
  }

  Future<void> _onAccommodationUpdate2(AccommodationUpdate2Event event, Emitter<AccommodationState> emit) async {
    emit(AccommodationUpdate2Loading());
    try{
      final response = await accommodationRepository.update(event.id,event.accommodationRequest);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationUpdate2Success(response.status));
      } else {
        emit(AccommodationUpdate2Error(response.message));
      }
    } catch(e){
      emit(AccommodationUpdate2Error(e.toString()));
    }
  }

}

