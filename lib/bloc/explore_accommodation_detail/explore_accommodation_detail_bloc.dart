import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/explore_repository.dart';


class ExploreAccommodationDetailBloc extends Bloc<ExploreAccommodationDetailEvent, ExploreAccommodationDetailState> {
  final ExploreRepository exploreRepository;

  ExploreAccommodationDetailBloc(this.exploreRepository) : super(GetAccommodationDetailInitial()){
    on<GetAccommodationByIdEvent>(_onGetAccommodationById);
  }

  Future<void> _onGetAccommodationById(GetAccommodationByIdEvent event, Emitter<ExploreAccommodationDetailState> emit) async {
    emit(GetAccommodationDetailLoading());
    try{
      final response = await exploreRepository.getAccommodationById(event.id);
      if(response.status){
        emit(GetAccommodationDetailSuccess(response.data!));
      } else {
        emit(GetAccommodationDetailError(response.message));
      }
    } catch(e){
      emit(GetAccommodationDetailError(e.toString()));
    }
  }
}