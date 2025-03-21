import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/accommodation_availability_repository.dart';

class AccommodationAvailabilityBloc extends Bloc<AccommodationAvailabilityEvent, AccommodationAvailabilityState> {
  final AccommodationAvailabilityRepository accommodationAvailabilityRepository;

  AccommodationAvailabilityBloc(this.accommodationAvailabilityRepository) : super(AccommodationAvailabilityInitial()){
    on<AccommodationAvailabilityGetEvent>(_onAccommodationAvailabilityGet);
    
  }

  Future<void> _onAccommodationAvailabilityGet(AccommodationAvailabilityGetEvent event, Emitter<AccommodationAvailabilityState> emit) async {
    emit(AccommodationAvailabilityGetLoading());
    try{
      final response = await accommodationAvailabilityRepository.getbyAccommodation(event.accommodationId);
      if(response.status){
        
        emit(AccommodationAvailabilityGetSuccess(response.data!));
      } else {
        emit(AccommodationAvailabilityGetError(response.message));
      }
    } catch(e){
      emit(AccommodationAvailabilityGetError(e.toString()));
    }
  }
}