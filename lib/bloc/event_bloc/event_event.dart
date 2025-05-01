import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/reserve/event_request_model.dart';
import 'package:tomatebnb/models/reserve/reserve_request_model.dart';

abstract class EventEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventCreateEvent extends EventEvent {
  final EventRequestModel requestModel;
  EventCreateEvent(this.requestModel);
  @override
  List<Object?> get props => [requestModel];
}


class EventGetByReserveEvent extends EventEvent {
  final int reserveId;
  EventGetByReserveEvent(this.reserveId);
  @override
  List<Object?> get props => [reserveId];
}

// class EventGetByIdEvent extends EventEvent {
//   final int id;
//   EventGetByIdEvent(this.id);
//   @override
//   List<Object> get props => [id];
// }

// class EventCheckinEvent extends EventEvent {
//   final int id;
//   final String dateCheckin;
//   EventCheckinEvent(this.id,this.dateCheckin);
//   @override
//   List<Object?> get props => [id,dateCheckin];
// }

// class EventCheckoutEvent extends EventEvent {
//   final int id;
//   final String dateCheckout;
//   EventCheckoutEvent(this.id,this.dateCheckout);
//   @override
//   List<Object?> get props => [id,dateCheckout];
// }

