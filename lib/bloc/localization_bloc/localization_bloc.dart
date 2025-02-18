import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/services/location_service.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final LocationService localizationService;

  LocalizationBloc(this.localizationService) : super(LocalizationInitial()){
    on<LocalizationGetEvent>(_onLocalizationGet);
  }

  Future<void> _onLocalizationGet(LocalizationGetEvent event, Emitter<LocalizationState> emit) async {
    emit(LocalizationGetLoading());
    try{
      final response = await localizationService.getCurrentLocation();     
        //await LocalizationRepository.setUserData(response.data!);
        emit(LocalizationGetSuccess(response.latitude, response.longitude));   
    } catch(e){
      emit(LocalizationGetError(e.toString()));
    }
  }
}