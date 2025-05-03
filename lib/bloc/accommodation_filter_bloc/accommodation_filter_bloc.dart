
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/accommodation_repository.dart';

class AccommodationFilterBloc extends Bloc<AccommodationFilterEvent, AccommodationFilterState> {
  final AccommodationRepository accommodationRepository;

  AccommodationFilterBloc(this.accommodationRepository) : super(AccommodationFilterInitial()) {
    on<FilterAccommodationsEvent>(_onFilterAccommodations);
  }

  Future<void> _onFilterAccommodations(FilterAccommodationsEvent event, Emitter<AccommodationFilterState> emit) async {
    emit(AccommodationFilterLoading());
    final response = await accommodationRepository.filterAccommodations(event.request);
    try {
      if(response.status){
        emit(AccommodationFilterLoaded(response.data!));
      } else {
        emit(AccommodationFilterError(response.message));
      }
    } catch (e) {
      emit(AccommodationFilterError(e.toString()));
    }
  }

}

