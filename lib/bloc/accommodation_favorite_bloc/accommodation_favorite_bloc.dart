import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/accommodation_favorite_repository.dart';

class AccommodationFavoriteBloc extends Bloc<AccommodationFavoriteEvent, AccommodationFavoriteState> {
  final AccommodationFavoriteRepository accommodationFavoriteRepository;
  AccommodationFavoriteBloc(this.accommodationFavoriteRepository) : super(AccommodationFavoriteInitial()) {
    on<GetAccommodationFavoriteEvent>(_onGetAccommodationFavorites);
  }
  
  Future<void> _onGetAccommodationFavorites(GetAccommodationFavoriteEvent event, Emitter<AccommodationFavoriteState> emit) async {
    emit(AccommodationFavoriteLoading());
    try {
      final response = await accommodationFavoriteRepository.getAccommodationFavorites();
      if (response.status) {
        emit(AccommodationFavoriteLoaded(response.data!));
      } else {
        emit(AccommodationFavoriteError(response.message));
      }
    } catch (e) {
      emit(AccommodationFavoriteError(e.toString()));
    }
  }
}