import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/accommodation_rule_repository.dart';

class AccommodationRuleBloc extends Bloc<AccommodationRuleEvent, AccommodationRuleState> {
  final AccommodationRuleRepository accommodationRuleRepository;

  AccommodationRuleBloc(this.accommodationRuleRepository) : super(AccommodationRuleInitial()){
    on<AccommodationRuleGetByAccommodationEvent>(_onAccommodationRuleGetByAccommodation);
    on<AccommodationRuleCreateEvent>(_onAccommodationRuleCreate);
    on<AccommodationRuleDeleteEvent>(_onAccommodationRuleDelete);
    on<AccommodationRuleUpdateEvent>(_onAccommodationRuleUpdate);
    
  }

  Future<void> _onAccommodationRuleGetByAccommodation(AccommodationRuleGetByAccommodationEvent event, Emitter<AccommodationRuleState> emit) async {
    emit(AccommodationRuleGetByAccommodationLoading());
    try{
      final response = await accommodationRuleRepository.getbyAccommodation(event.accommodationId);
      if(response.status){
        //await DescribeRepository.setUserData(response.data!);
        emit(AccommodationRuleGetByAccommodationSuccess(response.data!));
      } else {
        emit(AccommodationRuleGetByAccommodationError(response.message));
      }
    } catch(e){
      emit(AccommodationRuleGetByAccommodationError(e.toString()));
    }
  }

     Future<void> _onAccommodationRuleCreate(AccommodationRuleCreateEvent event, Emitter<AccommodationRuleState> emit) async {
    emit(AccommodationRuleCreateLoading());
    try{
      final response = await accommodationRuleRepository.createAccommodationRule(event.accommodationRuleRequest);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationRuleCreateSuccess(response.data!));
      } else {
        emit(AccommodationRuleCreateError(response.message));
      }
    } catch(e){
      emit(AccommodationRuleCreateError(e.toString()));
      
    }
  }


   Future<void> _onAccommodationRuleUpdate(AccommodationRuleUpdateEvent event, Emitter<AccommodationRuleState> emit) async {
    emit(AccommodationRuleUpdateLoading());
    try{
      final response = await accommodationRuleRepository.update(event.id, event.accommodationRuleRequest);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationRuleUpdateSuccess(response.status));
      } else {
        emit(AccommodationRuleUpdateError(response.message));
      }
    } catch(e){
      emit(AccommodationRuleUpdateError(e.toString()));
    }
  }
  Future<void> _onAccommodationRuleDelete(AccommodationRuleDeleteEvent event, Emitter<AccommodationRuleState> emit) async {
    emit(AccommodationRuleDeleteLoading());
    try{
      final response = await accommodationRuleRepository.delete(event.ruleId);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationRuleDeleteSuccess(response.data!));
      } else {
        emit(AccommodationRuleDeleteError(response.message));
      }
    } catch(e){
      emit(AccommodationRuleDeleteError(e.toString()));
    }
  }


}