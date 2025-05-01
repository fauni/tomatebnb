import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/reserve/event_response_model.dart';
abstract class EventState extends Equatable {
  @override
  List<Object> get props => [];
}
class EventInitial extends EventState {}

//estados para guardar evento de reserva
class EventCreateLoading extends EventState {}

class EventCreateSuccess extends EventState {
  final EventResponseModel responseEvent;
  EventCreateSuccess(
    this.responseEvent
  );
  @override
  List<Object> get props => [responseEvent];
}

class EventCreateError extends EventState {
  final String message;
  EventCreateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

// Estados para el listado de eventos(checkin o checkout) por reserva

class EventGetByReserveLoading extends EventState {}

class EventGetByReserveSuccess extends EventState {
  final List<EventResponseModel> responseEvents;
  EventGetByReserveSuccess(
    this.responseEvents
  );
  @override
  List<Object> get props => [responseEvents];
}

class EventGetByReserveError extends EventState {
  final String message;
  EventGetByReserveError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

// // Estados para obtener reserva por id
// class EventGetByIdLoading extends EventState {}
// class EventGetByIdSuccess extends EventState {
//   final EventResponseModel responseEvent;
//   EventGetByIdSuccess(
//     this.responseEvent
//   );
//   @override
//   List<Object> get props => [responseEvent];
// }
// class EventGetByIdError extends EventState {
//   final String message;
//   EventGetByIdError(
//     this.message
//   );
//   @override
//   List<Object> get props => [message];
// }

// //Estados para agregar hora de checkin estimada en la reserva 
// class EventCheckinLoading extends EventState {}

// class EventCheckinSuccess extends EventState {
//   final bool status;
//   EventCheckinSuccess(
//     this.status
//   );
//   @override
//   List<Object> get props => [status];
// }

// class EventCheckinError extends EventState {
//   final String message;
//   EventCheckinError(
//     this.message
//   );
//   @override
//   List<Object> get props => [message];
// }

// //Estados para agregar hora de checkout estimada en la reserva 
// class EventCheckoutLoading extends EventState {}

// class EventCheckoutSuccess extends EventState {
//   final bool status;
//   EventCheckoutSuccess(
//     this.status
//   );
//   @override
//   List<Object> get props => [status];
// }

// class EventCheckoutError extends EventState {
//   final String message;
//   EventCheckoutError(
//     this.message
//   );
//   @override
//   List<Object> get props => [message];
// }