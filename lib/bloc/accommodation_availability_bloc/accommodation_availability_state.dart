import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/reserve/accommodation_availability_response_model.dart';


abstract class AccommodationAvailabilityState extends Equatable {
  @override
  List<Object> get props => [];
}
class AccommodationAvailabilityInitial extends AccommodationAvailabilityState {}

//estados para obtener disponibilidades de alojamiento
class AccommodationAvailabilityGetLoading extends AccommodationAvailabilityState {}

class AccommodationAvailabilityGetSuccess extends AccommodationAvailabilityState {
  final List<AccommodationAvailabilityResponseModel> responseAccommodationAvailabilitys;
  AccommodationAvailabilityGetSuccess(
    this.responseAccommodationAvailabilitys
  );
  @override
  List<Object> get props => [responseAccommodationAvailabilitys];
}

class AccommodationAvailabilityGetError extends AccommodationAvailabilityState {
  final String message;
  AccommodationAvailabilityGetError(
    this.message
  );
  @override
  List<Object> get props => [message];
}


