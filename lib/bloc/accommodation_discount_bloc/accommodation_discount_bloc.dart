import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/accommodation_discount_repository.dart';

class AccommodationDiscountBloc extends Bloc<AccommodationDiscountEvent, AccommodationDiscountState> {
  final AccommodationDiscountRepository accommodationDiscountRepository;

  AccommodationDiscountBloc(this.accommodationDiscountRepository) : super(AccommodationDiscountInitial()){
    on<AccommodationDiscountGetByAccommodationEvent>(_onAccommodationDiscountGetByAccommodation);
    on<AccommodationDiscountCreateEvent>(_onAccommodationDiscountCreate);
    on<AccommodationDiscountDeleteEvent>(_onAccommodationDiscountDelete);
    on<AccommodationDiscountUpdateEvent>(_onAccommodationDiscountUpdate);
    
  }

  Future<void> _onAccommodationDiscountGetByAccommodation(AccommodationDiscountGetByAccommodationEvent event, Emitter<AccommodationDiscountState> emit) async {
    emit(AccommodationDiscountGetByAccommodationLoading());
    try{
      final response = await accommodationDiscountRepository.getbyAccommodation(event.accommodationId);
      if(response.status){
        //await DescribeRepository.setUserData(response.data!);
        emit(AccommodationDiscountGetByAccommodationSuccess(response.data!));
      } else {
        emit(AccommodationDiscountGetByAccommodationError(response.message));
      }
    } catch(e){
      emit(AccommodationDiscountGetByAccommodationError(e.toString()));
    }
  }

     Future<void> _onAccommodationDiscountCreate(AccommodationDiscountCreateEvent event, Emitter<AccommodationDiscountState> emit) async {
    emit(AccommodationDiscountCreateLoading());
    try{
      final response = await accommodationDiscountRepository.createAccommodationDiscount(event.accommodationDiscountRequest);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationDiscountCreateSuccess(response.data!));
      } else {
        emit(AccommodationDiscountCreateError(response.message));
      }
    } catch(e){
      emit(AccommodationDiscountCreateError(e.toString()));
      
    }
  }

  Future<void> _onAccommodationDiscountDelete(AccommodationDiscountDeleteEvent event, Emitter<AccommodationDiscountState> emit) async {
    emit(AccommodationDiscountDeleteLoading());
    try{
      final response = await accommodationDiscountRepository.delete(event.priceId);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationDiscountDeleteSuccess(response.data!));
      } else {
        emit(AccommodationDiscountDeleteError(response.message));
      }
    } catch(e){
      emit(AccommodationDiscountDeleteError(e.toString()));
    }
  }

   Future<void> _onAccommodationDiscountUpdate(AccommodationDiscountUpdateEvent event, Emitter<AccommodationDiscountState> emit) async {
    emit(AccommodationDiscountUpdateLoading());
    try{
      final response = await accommodationDiscountRepository.update(event.id, event.accommodationDiscountRequest);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationDiscountUpdateSuccess(response.status));
      } else {
        emit(AccommodationDiscountUpdateError(response.message));
      }
    } catch(e){
      emit(AccommodationDiscountUpdateError(e.toString()));
    }
  }


}