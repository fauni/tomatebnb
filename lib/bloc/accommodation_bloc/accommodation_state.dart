import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_model.dart';


abstract class AccommodationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AccommodationInitial extends AccommodationState {}

// Estados para el listado de alojamientos por usuario

class AccommodationLoading extends AccommodationState {}

class AccommodationGetSuccess extends AccommodationState {
  final List<AccommodationResponseModel> responseAccommodations;
  AccommodationGetSuccess(
    this.responseAccommodations
  );
  @override
  List<Object> get props => [responseAccommodations];
}

class AccommodationGetError extends AccommodationState {
  final String message;
  AccommodationGetError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

// Estados para el registro de alojamientos
class AccommodationCreateLoading extends AccommodationState {}

class AccommodationCreateSuccess extends AccommodationState {
  final AccommodationResponseModel responseAccommodation;
  AccommodationCreateSuccess(
    this.responseAccommodation
  );
  @override
  List<Object> get props => [responseAccommodation];
}

class AccommodationCreateError extends AccommodationState {
  final String message;
  AccommodationCreateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}



