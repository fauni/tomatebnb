import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/reserve/reserve_request_model.dart';

abstract class ReserveEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReserveCreateEvent extends ReserveEvent {
  final ReserveRequestModel requestModel;
  ReserveCreateEvent(this.requestModel);
  @override
  List<Object?> get props => [requestModel];
}


class ReserveGetByUserEvent extends ReserveEvent {
  
  ReserveGetByUserEvent();
  @override
  List<Object?> get props => [];
}

class ReserveGetByIdEvent extends ReserveEvent {
  final int id;
  ReserveGetByIdEvent(this.id);
  @override
  List<Object> get props => [id];
}

