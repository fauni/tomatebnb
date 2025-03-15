import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/accommodation_instruction_repository.dart';

class AccommodationInstructionBloc extends Bloc<AccommodationInstructionEvent, AccommodationInstructionState> {
  final AccommodationInstructionRepository accommodationInstructionRepository;

  AccommodationInstructionBloc(this.accommodationInstructionRepository) : super(AccommodationInstructionInitial()){
    on<AccommodationInstructionGetByAccommodationEvent>(_onAccommodationInstructionGetByAccommodation);    
    on<AccommodationInstructionUpdateEvent>(_onAccommodationInstructionUpdate);
  }

  Future<void> _onAccommodationInstructionGetByAccommodation(AccommodationInstructionGetByAccommodationEvent event, Emitter<AccommodationInstructionState> emit) async {
    emit(AccommodationInstructionGetByAccommodationLoading());
    try{
      final response = await accommodationInstructionRepository.getbyAccommodation(event.accommodationId);
      if(response.status){
        //await DescribeRepository.setUserData(response.data!);
        emit(AccommodationInstructionGetByAccommodationSuccess(response.data!));
      } else {
        emit(AccommodationInstructionGetByAccommodationError(response.message));
      }
    } catch(e){
      emit(AccommodationInstructionGetByAccommodationError(e.toString()));
    }
  }

   Future<void> _onAccommodationInstructionUpdate(AccommodationInstructionUpdateEvent event, Emitter<AccommodationInstructionState> emit) async {
    emit(AccommodationInstructionUpdateLoading());
    try{
      final response = await accommodationInstructionRepository.updateDescription(event.id, event.description);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationInstructionUpdateSuccess(response.status));
      } else {
        emit(AccommodationInstructionUpdateError(response.message));
      }
    } catch(e){
      emit(AccommodationInstructionUpdateError(e.toString()));
    }
  }

}