import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/accommodation_repository.dart';

class AccommodationBloc extends Bloc<AccommodationEvent, AccommodationState> {
  final AccommodationRepository accommodationRepository;

  AccommodationBloc(this.accommodationRepository) : super(AccommodationInitial()){
    on<AccommodationGetEvent>(_onAccommodationGet);
    on<AccommodationCreateEvent>(_onAccommodationCreate);
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
  
}