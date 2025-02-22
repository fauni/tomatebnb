import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/accommodation_aspect_repository.dart';

class AccommodationAspectBloc extends Bloc<AccommodationAspectEvent, AccommodationAspectState> {
  final AccommodationAspectRepository accommodationAspectRepository;

  AccommodationAspectBloc(this.accommodationAspectRepository) : super(AccommodationAspectInitial()){
    on<AccommodationAspectGetEvent>(_onAccommodationAspectGet);
    on<AccommodationAspectCreateEvent>(_onAccommodationAspectCreate);
    on<AccommodationAspectDeleteEvent>(_onAccommodationAspectDelete);
    
  }

  Future<void> _onAccommodationAspectGet(AccommodationAspectGetEvent event, Emitter<AccommodationAspectState> emit) async {
    emit(AccommodationAspectGetLoading());
    try{
      final response = await accommodationAspectRepository.getbyAccommodation(event.accommodationId);
      if(response.status){
        //await DescribeRepository.setUserData(response.data!);
        emit(AccommodationAspectGetSuccess(response.data!));
      } else {
        emit(AccommodationAspectGetError(response.message));
      }
    } catch(e){
      emit(AccommodationAspectGetError(e.toString()));
    }
  }

     Future<void> _onAccommodationAspectCreate(AccommodationAspectCreateEvent event, Emitter<AccommodationAspectState> emit) async {
    emit(AccommodationAspectCreateLoading());
    try{
      final response = await accommodationAspectRepository.createAccommodationAspect(event.accommodationId,event.aspectId);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationAspectCreateSuccess(response.data!));
      } else {
        emit(AccommodationAspectCreateError(response.message));
      }
    } catch(e){
      emit(AccommodationAspectCreateError(e.toString()));
      
    }
  }

  Future<void> _onAccommodationAspectDelete(AccommodationAspectDeleteEvent event, Emitter<AccommodationAspectState> emit) async {
    emit(AccommodationAspectDeleteLoading());
    try{
      final response = await accommodationAspectRepository.delete(event.accommodationId,event.aspectId);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationAspectDeleteSuccess(response.data!));
      } else {
        emit(AccommodationAspectDeleteError(response.message));
      }
    } catch(e){
      emit(AccommodationAspectDeleteError(e.toString()));
    }
  }
}