import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_type_response_model.dart';

abstract class AccommodationTypeState extends Equatable {
  @override
  List<Object> get props => [];
}
class AccommodationTypeInitial extends AccommodationTypeState {}

//estados para obtener tipos de alojamiento
class AccommodationTypeGetLoading extends AccommodationTypeState {}

class AccommodationTypeGetSuccess extends AccommodationTypeState {
  final List<AccommodationTypeResponseModel> responseAccommodationTypes;
  AccommodationTypeGetSuccess(
    this.responseAccommodationTypes
  );
  @override
  List<Object> get props => [responseAccommodationTypes];
}

class AccommodationTypeGetError extends AccommodationTypeState {
  final String message;
  AccommodationTypeGetError(
    this.message
  );
  @override
  List<Object> get props => [message];
}