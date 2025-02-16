import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/accommodation_type_repository.dart';

class AccommodationTypeBloc extends Bloc<AccommodationTypeEvent, AccommodationTypeState> {
  final AccommodationTypeRepository accommodationTypeRepository;

  AccommodationTypeBloc(this.accommodationTypeRepository) : super(AccommodationTypeInitial()){
    on<AccommodationTypeGetEvent>(_onAccommodationTypeGet);
  }

  Future<void> _onAccommodationTypeGet(AccommodationTypeGetEvent event, Emitter<AccommodationTypeState> emit) async {
    emit(AccommodationTypeGetLoading());
    try{
      final response = await accommodationTypeRepository.get();
      if(response.status){
        //await DescribeRepository.setUserData(response.data!);
        emit(AccommodationTypeGetSuccess(response.data!));
      } else {
        emit(AccommodationTypeGetError(response.message));
      }
    } catch(e){
      emit(AccommodationTypeGetError(e.toString()));
    }
  }
}