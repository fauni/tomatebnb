import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_price_response_model.dart';


abstract class AccommodationPriceState extends Equatable {
  @override
  List<Object> get props => [];
}
class AccommodationPriceInitial extends AccommodationPriceState {}

//estados para obtener precios de alojamiento 
class AccommodationPriceGetByAccommodationLoading extends AccommodationPriceState {}

class AccommodationPriceGetByAccommodationSuccess extends AccommodationPriceState {
  final List<AccommodationPriceResponseModel> responseAccommodationPrices;
  AccommodationPriceGetByAccommodationSuccess(
    this.responseAccommodationPrices
  );
  @override
  List<Object> get props => [responseAccommodationPrices];
}

class AccommodationPriceGetByAccommodationError extends AccommodationPriceState {
  final String message;
  AccommodationPriceGetByAccommodationError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//estados para guardar servicios de alojamiento
class AccommodationPriceCreateLoading extends AccommodationPriceState {}

class AccommodationPriceCreateSuccess extends AccommodationPriceState {
  final AccommodationPriceResponseModel responseAccommodationPrice;
  AccommodationPriceCreateSuccess(
    this.responseAccommodationPrice
  );
  @override
  List<Object> get props => [responseAccommodationPrice];
}

class AccommodationPriceCreateError extends AccommodationPriceState {
  final String message;
  AccommodationPriceCreateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//estados para eliminar precios de alojamiento
class AccommodationPriceDeleteLoading extends AccommodationPriceState {}

class AccommodationPriceDeleteSuccess extends AccommodationPriceState {
  final AccommodationPriceResponseModel responseAccommodationPrice;
  AccommodationPriceDeleteSuccess(
    this.responseAccommodationPrice
  );
  @override
  List<Object> get props => [responseAccommodationPrice];
}

class AccommodationPriceDeleteError extends AccommodationPriceState {
  final String message;
  AccommodationPriceDeleteError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//Estados para actualizar alojamiento por id
class AccommodationPriceUpdateLoading extends AccommodationPriceState {}

class AccommodationPriceUpdateSuccess extends AccommodationPriceState {
  final bool status;
  AccommodationPriceUpdateSuccess(
    this.status
  );
  @override
  List<Object> get props => [status];
}

class AccommodationPriceUpdateError extends AccommodationPriceState {
  final String message;
  AccommodationPriceUpdateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}