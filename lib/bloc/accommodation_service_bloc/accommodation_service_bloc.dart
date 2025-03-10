import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/accommodation_service_repository.dart';

class AccommodationServiceBloc extends Bloc<AccommodationServiceEvent, AccommodationServiceState> {
  final AccommodationServiceRepository accommodationServiceRepository;

  AccommodationServiceBloc(this.accommodationServiceRepository) : super(AccommodationServiceInitial()){
    on<AccommodationServiceGetEvent>(_onAccommodationServiceGet);
    on<AccommodationServicecGetEvent>(_onAccommodationServicecGet);
    on<AccommodationServiceCreateEvent>(_onAccommodationServiceCreate);
    on<AccommodationServiceDeleteEvent>(_onAccommodationServiceDelete);
  }

  Future<void> _onAccommodationServiceGet(AccommodationServiceGetEvent event, Emitter<AccommodationServiceState> emit) async {
    emit(AccommodationServiceGetLoading());
    try{
      final response = await accommodationServiceRepository.getbyAccommodation(event.accommodationId);
      if(response.status){
        //await DescribeRepository.setUserData(response.data!);
        emit(AccommodationServiceGetSuccess(response.data!));
      } else {
        emit(AccommodationServiceGetError(response.message));
      }
    } catch(e){
      emit(AccommodationServiceGetError(e.toString()));
    }
  }

    Future<void> _onAccommodationServicecGet(AccommodationServicecGetEvent event, Emitter<AccommodationServiceState> emit) async {
    emit(AccommodationServicecGetLoading());
    try{
      final response = await accommodationServiceRepository.getbyCompleteByAccommodation(event.accommodationId);
      if(response.status){
        //await DescribeRepository.setUserData(response.data!);
        emit(AccommodationServicecGetSuccess(response.data!));
      } else {
        emit(AccommodationServicecGetError(response.message));
      }
    } catch(e){
      emit(AccommodationServicecGetError(e.toString()));
    }
  }

     Future<void> _onAccommodationServiceCreate(AccommodationServiceCreateEvent event, Emitter<AccommodationServiceState> emit) async {
    emit(AccommodationServiceCreateLoading());
    try{
      final response = await accommodationServiceRepository.createAccommodationService(event.accommodationId,event.serviceId);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationServiceCreateSuccess(response.data!));
      } else {
        emit(AccommodationServiceCreateError(response.message));
      }
    } catch(e){
      emit(AccommodationServiceCreateError(e.toString()));
      
    }
  }

  Future<void> _onAccommodationServiceDelete(AccommodationServiceDeleteEvent event, Emitter<AccommodationServiceState> emit) async {
    emit(AccommodationServiceDeleteLoading());
    try{
      final response = await accommodationServiceRepository.delete(event.accommodationId,event.serviceId);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationServiceDeleteSuccess(response.data!));
      } else {
        emit(AccommodationServiceDeleteError(response.message));
      }
    } catch(e){
      emit(AccommodationServiceDeleteError(e.toString()));
    }
  }
}