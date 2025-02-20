import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_service_response_model.dart';

abstract class AccommodationServiceState extends Equatable {
  @override
  List<Object> get props => [];
}
class AccommodationServiceInitial extends AccommodationServiceState {}

//estados para obtener servicios de alojamiento
class AccommodationServiceGetLoading extends AccommodationServiceState {}

class AccommodationServiceGetSuccess extends AccommodationServiceState {
  final List<AccommodationServiceResponseModel> responseAccommodationServices;
  AccommodationServiceGetSuccess(
    this.responseAccommodationServices
  );
  @override
  List<Object> get props => [responseAccommodationServices];
}

class AccommodationServiceGetError extends AccommodationServiceState {
  final String message;
  AccommodationServiceGetError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//estados para guardar servicios de alojamiento
class AccommodationServiceCreateLoading extends AccommodationServiceState {}

class AccommodationServiceCreateSuccess extends AccommodationServiceState {
  final AccommodationServiceResponseModel responseAccommodationService;
  AccommodationServiceCreateSuccess(
    this.responseAccommodationService
  );
  @override
  List<Object> get props => [responseAccommodationService];
}

class AccommodationServiceCreateError extends AccommodationServiceState {
  final String message;
  AccommodationServiceCreateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//estados para eliminar servicios de alojamiento
class AccommodationServiceDeleteLoading extends AccommodationServiceState {}

class AccommodationServiceDeleteSuccess extends AccommodationServiceState {
  final AccommodationServiceResponseModel responseAccommodationService;
  AccommodationServiceDeleteSuccess(
    this.responseAccommodationService
  );
  @override
  List<Object> get props => [responseAccommodationService];
}

class AccommodationServiceDeleteError extends AccommodationServiceState {
  final String message;
  AccommodationServiceDeleteError(
    this.message
  );
  @override
  List<Object> get props => [message];
}