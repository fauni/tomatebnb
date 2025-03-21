
import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/reserve/reserve_request_model.dart';
import 'package:tomatebnb/models/reserve/reserve_response_model.dart';
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


