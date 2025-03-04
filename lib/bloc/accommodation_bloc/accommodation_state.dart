import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_model.dart';


abstract class AccommodationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AccommodationInitial extends AccommodationState {}

// Estados para el listado de alojamientos por usuario

class AccommodationLoading extends AccommodationState {}

class AccommodationGetSuccess extends AccommodationState {
  final List<AccommodationResponseCompleteModel> responseAccommodations;
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
//Estados para obtencion de alojamiento por id
class AccommodationGetByIdLoading extends AccommodationState {}

class AccommodationGetByIdSuccess extends AccommodationState {
  final AccommodationResponseCompleteModel responseAccommodation;
  AccommodationGetByIdSuccess(
    this.responseAccommodation
  );
  @override
  List<Object> get props => [responseAccommodation];
}

class AccommodationGetByIdError extends AccommodationState {
  final String message;
  AccommodationGetByIdError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//Estados para actualizar alojamiento por id
class AccommodationUpdateLoading extends AccommodationState {}

class AccommodationUpdateSuccess extends AccommodationState {
  final bool status;
  AccommodationUpdateSuccess(
    this.status
  );
  @override
  List<Object> get props => [status];
}

class AccommodationUpdateError extends AccommodationState {
  final String message;
  AccommodationUpdateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//Estados para actualizar alojamiento por id
class AccommodationUpdate2Loading extends AccommodationState {}

class AccommodationUpdate2Success extends AccommodationState {
  final bool status;
  AccommodationUpdate2Success(
    this.status
  );
  @override
  List<Object> get props => [status];
}

class AccommodationUpdate2Error extends AccommodationState {
  final String message;
  AccommodationUpdate2Error(
    this.message
  );
  @override
  List<Object> get props => [message];
}
