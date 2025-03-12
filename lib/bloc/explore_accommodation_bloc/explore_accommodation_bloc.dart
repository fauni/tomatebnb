import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/explore_repository.dart';


class ExploreAccommodationBloc extends Bloc<ExploreAccommodationEvent, ExploreAccommodationState> {
  final ExploreRepository exploreRepository;

  ExploreAccommodationBloc(this.exploreRepository) : super(GetAccommodationNearbyInitial()){
    on<NearbyAccommodationGetEvent>(_onNearbyAccommodationGet);
  }

  Future<void> _onNearbyAccommodationGet(NearbyAccommodationGetEvent event, Emitter<ExploreAccommodationState> emit) async {
    emit(GetAccommodationNearbyLoading());
    try{
      final response = await exploreRepository.getAccommodationNearby();
      if(response.status){
        emit(GetAccommodationNearbySuccess(response.data!));
      } else {
        emit(GetAccommodationNearbyError(response.message));
      }
    } catch(e){
      emit(GetAccommodationNearbyError(e.toString()));
    }
  }
}