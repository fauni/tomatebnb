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