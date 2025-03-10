import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_aspect_response_model.dart';
// import 'package:tomatebnb/models/accommodation/accommodation_service_response_model.dart';

abstract class AccommodationAspectState extends Equatable {
  @override
  List<Object> get props => [];
}
class AccommodationAspectInitial extends AccommodationAspectState {}

//estados para obtener servicios de alojamiento
class AccommodationAspectGetLoading extends AccommodationAspectState {}

class AccommodationAspectGetSuccess extends AccommodationAspectState {
  final List<AccommodationAspectResponseModel> responseAccommodationAspects;
  AccommodationAspectGetSuccess(
    this.responseAccommodationAspects
  );
  @override
  List<Object> get props => [responseAccommodationAspects];
}

class AccommodationAspectGetError extends AccommodationAspectState {
  final String message;
  AccommodationAspectGetError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//estados para guardar servicios de alojamiento
class AccommodationAspectCreateLoading extends AccommodationAspectState {}

class AccommodationAspectCreateSuccess extends AccommodationAspectState {
  final AccommodationAspectResponseModel responseAccommodationAspect;
  AccommodationAspectCreateSuccess(
    this.responseAccommodationAspect
  );
  @override
  List<Object> get props => [responseAccommodationAspect];
}

class AccommodationAspectCreateError extends AccommodationAspectState {
  final String message;
  AccommodationAspectCreateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//estados para eliminar servicios de alojamiento
class AccommodationAspectDeleteLoading extends AccommodationAspectState {}

class AccommodationAspectDeleteSuccess extends AccommodationAspectState {
  final AccommodationAspectResponseModel responseAccommodationAspect;
  AccommodationAspectDeleteSuccess(
    this.responseAccommodationAspect
  );
  @override
  List<Object> get props => [responseAccommodationAspect];
}

class AccommodationAspectDeleteError extends AccommodationAspectState {
  final String message;
  AccommodationAspectDeleteError(
    this.message
  );
  @override
  List<Object> get props => [message];
}