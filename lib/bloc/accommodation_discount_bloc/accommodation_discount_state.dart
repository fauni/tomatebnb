import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_discount_response_model.dart';


abstract class AccommodationDiscountState extends Equatable {
  @override
  List<Object> get props => [];
}
class AccommodationDiscountInitial extends AccommodationDiscountState {}

//estados para obtener precios de alojamiento 
class AccommodationDiscountGetByAccommodationLoading extends AccommodationDiscountState {}

class AccommodationDiscountGetByAccommodationSuccess extends AccommodationDiscountState {
  final List<AccommodationDiscountResponseModel> responseAccommodationDiscounts;
  AccommodationDiscountGetByAccommodationSuccess(
    this.responseAccommodationDiscounts
  );
  @override
  List<Object> get props => [responseAccommodationDiscounts];
}

class AccommodationDiscountGetByAccommodationError extends AccommodationDiscountState {
  final String message;
  AccommodationDiscountGetByAccommodationError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//estados para guardar servicios de alojamiento
class AccommodationDiscountCreateLoading extends AccommodationDiscountState {}

class AccommodationDiscountCreateSuccess extends AccommodationDiscountState {
  final AccommodationDiscountResponseModel responseAccommodationDiscount;
  AccommodationDiscountCreateSuccess(
    this.responseAccommodationDiscount
  );
  @override
  List<Object> get props => [responseAccommodationDiscount];
}

class AccommodationDiscountCreateError extends AccommodationDiscountState {
  final String message;
  AccommodationDiscountCreateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//estados para eliminar precios de alojamiento
class AccommodationDiscountDeleteLoading extends AccommodationDiscountState {}

class AccommodationDiscountDeleteSuccess extends AccommodationDiscountState {
  final AccommodationDiscountResponseModel responseAccommodationDiscount;
  AccommodationDiscountDeleteSuccess(
    this.responseAccommodationDiscount
  );
  @override
  List<Object> get props => [responseAccommodationDiscount];
}

class AccommodationDiscountDeleteError extends AccommodationDiscountState {
  final String message;
  AccommodationDiscountDeleteError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//Estados para actualizar alojamiento por id
class AccommodationDiscountUpdateLoading extends AccommodationDiscountState {}

class AccommodationDiscountUpdateSuccess extends AccommodationDiscountState {
  final bool status;
  AccommodationDiscountUpdateSuccess(
    this.status
  );
  @override
  List<Object> get props => [status];
}

class AccommodationDiscountUpdateError extends AccommodationDiscountState {
  final String message;
  AccommodationDiscountUpdateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}