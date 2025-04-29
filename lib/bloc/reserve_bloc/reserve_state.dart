import 'package:equatable/equatable.dart';

import 'package:tomatebnb/models/reserve/reserve_response_model.dart';

abstract class ReserveState extends Equatable {
  @override
  List<Object> get props => [];
}
class ReserveInitial extends ReserveState {}

//estados para guardar reserva de alojamiento
class ReserveCreateLoading extends ReserveState {}

class ReserveCreateSuccess extends ReserveState {
  final ReserveResponseModel responseReserve;
  ReserveCreateSuccess(
    this.responseReserve
  );
  @override
  List<Object> get props => [responseReserve];
}

class ReserveCreateError extends ReserveState {
  final String message;
  ReserveCreateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

// Estados para el listado de reservas por usuario

class ReserveGetByUserLoading extends ReserveState {}

class ReserveGetByUserSuccess extends ReserveState {
  final List<ReserveResponseModel> responseReserves;
  ReserveGetByUserSuccess(
    this.responseReserves
  );
  @override
  List<Object> get props => [responseReserves];
}

class ReserveGetByUserError extends ReserveState {
  final String message;
  ReserveGetByUserError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

// Estados para obtener reserva por id
class ReserveGetByIdLoading extends ReserveState {}
class ReserveGetByIdSuccess extends ReserveState {
  final ReserveResponseModel responseReserve;
  ReserveGetByIdSuccess(
    this.responseReserve
  );
  @override
  List<Object> get props => [responseReserve];
}
class ReserveGetByIdError extends ReserveState {
  final String message;
  ReserveGetByIdError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//Estados para agregar hora de checkin estimada en la reserva 
class ReserveCheckinLoading extends ReserveState {}

class ReserveCheckinSuccess extends ReserveState {
  final bool status;
  ReserveCheckinSuccess(
    this.status
  );
  @override
  List<Object> get props => [status];
}

class ReserveCheckinError extends ReserveState {
  final String message;
  ReserveCheckinError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//Estados para agregar hora de checkout estimada en la reserva 
class ReserveCheckoutLoading extends ReserveState {}

class ReserveCheckoutSuccess extends ReserveState {
  final bool status;
  ReserveCheckoutSuccess(
    this.status
  );
  @override
  List<Object> get props => [status];
}

class ReserveCheckoutError extends ReserveState {
  final String message;
  ReserveCheckoutError(
    this.message
  );
  @override
  List<Object> get props => [message];
}