import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/accommodation_price_repository.dart';

class AccommodationPriceBloc extends Bloc<AccommodationPriceEvent, AccommodationPriceState> {
  final AccommodationPriceRepository accommodationPriceRepository;

  AccommodationPriceBloc(this.accommodationPriceRepository) : super(AccommodationPriceInitial()){
    on<AccommodationPriceGetByAccommodationEvent>(_onAccommodationPriceGetByAccommodation);
    on<AccommodationPriceCreateEvent>(_onAccommodationPriceCreate);
    on<AccommodationPriceDeleteEvent>(_onAccommodationPriceDelete);
    on<AccommodationPriceUpdateEvent>(_onAccommodationPriceUpdate);
    
  }

  Future<void> _onAccommodationPriceGetByAccommodation(AccommodationPriceGetByAccommodationEvent event, Emitter<AccommodationPriceState> emit) async {
    emit(AccommodationPriceGetByAccommodationLoading());
    try{
      final response = await accommodationPriceRepository.getbyAccommodation(event.accommodationId);
      if(response.status){
        //await DescribeRepository.setUserData(response.data!);
        emit(AccommodationPriceGetByAccommodationSuccess(response.data!));
      } else {
        emit(AccommodationPriceGetByAccommodationError(response.message));
      }
    } catch(e){
      emit(AccommodationPriceGetByAccommodationError(e.toString()));
    }
  }

     Future<void> _onAccommodationPriceCreate(AccommodationPriceCreateEvent event, Emitter<AccommodationPriceState> emit) async {
    emit(AccommodationPriceCreateLoading());
    try{
      final response = await accommodationPriceRepository.createAccommodationPrice(event.accommodationPriceRequest);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationPriceCreateSuccess(response.data!));
      } else {
        emit(AccommodationPriceCreateError(response.message));
      }
    } catch(e){
      emit(AccommodationPriceCreateError(e.toString()));
      
    }
  }

  Future<void> _onAccommodationPriceDelete(AccommodationPriceDeleteEvent event, Emitter<AccommodationPriceState> emit) async {
    emit(AccommodationPriceDeleteLoading());
    try{
      final response = await accommodationPriceRepository.delete(event.priceId);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationPriceDeleteSuccess(response.data!));
      } else {
        emit(AccommodationPriceDeleteError(response.message));
      }
    } catch(e){
      emit(AccommodationPriceDeleteError(e.toString()));
    }
  }

   Future<void> _onAccommodationPriceUpdate(AccommodationPriceUpdateEvent event, Emitter<AccommodationPriceState> emit) async {
    emit(AccommodationPriceUpdateLoading());
    try{
      final response = await accommodationPriceRepository.update(event.id, event.accommodationPriceRequest);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationPriceUpdateSuccess(response.status));
      } else {
        emit(AccommodationPriceUpdateError(response.message));
      }
    } catch(e){
      emit(AccommodationPriceUpdateError(e.toString()));
    }
  }


}