import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/accommodation_favorite_repository.dart';

class AccommodationFavoriteBloc extends Bloc<AccommodationFavoriteEvent, AccommodationFavoriteState> {
  final AccommodationFavoriteRepository accommodationFavoriteRepository;
  AccommodationFavoriteBloc(this.accommodationFavoriteRepository) : super(AccommodationFavoriteInitial()) {
    on<GetAccommodationFavoriteEvent>(_onGetAccommodationFavorites);
    on<AddAccommodationFavoriteEvent>(_onAddAccommodationFavorite);
    on<RemoveAccommodationFavoriteEvent>(_onRemoveAccommodationFavorite);
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

  Future<void> _onAddAccommodationFavorite(AddAccommodationFavoriteEvent event, Emitter<AccommodationFavoriteState> emit) async {
    try {
      final response = await accommodationFavoriteRepository.addAccommodationFavorite(event.accommodationId);
      if (response.status) {
        emit(AccommodationFavoriteAdded(response.message));
      } else {
        emit(AccommodationFavoriteError(response.message));
      }
    } catch (e) {
      emit(AccommodationFavoriteError(e.toString()));
    }
  }
  Future<void> _onRemoveAccommodationFavorite(RemoveAccommodationFavoriteEvent event, Emitter<AccommodationFavoriteState> emit) async {
    try {
      final response = await accommodationFavoriteRepository.removeAccommodationFavorite(event.accommodationId);
      if (response.status) {
        emit(AccommodationFavoriteRemoved(response.message));
      } else {
        emit(AccommodationFavoriteError(response.message));
      }
    } catch (e) {
      emit(AccommodationFavoriteError(e.toString()));
    }
  }
}