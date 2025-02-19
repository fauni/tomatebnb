import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/accommodation_service_repository.dart';

class AccommodationServiceBloc extends Bloc<AccommodationServiceEvent, AccommodationServiceState> {
  final AccommodationServiceRepository accommodationServiceRepository;

  AccommodationServiceBloc(this.accommodationServiceRepository) : super(AccommodationServiceInitial()){
    on<AccommodationServiceGetEvent>(_onAccommodationServiceGet);
    on<AccommodationServiceCreateEvent>(_onAccommodationServiceCreate);
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
}