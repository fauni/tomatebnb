
import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_request_model.dart';
abstract class AccommodationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccommodationGetEvent extends AccommodationEvent {
  AccommodationGetEvent();

  @override
  List<Object?> get props => [];
}

class AccommodationCreateEvent extends AccommodationEvent {
  AccommodationCreateEvent();
  @override
  List<Object?> get props => [];
}

class AccommodationGetByIdEvent extends AccommodationEvent {
  final int id;
  AccommodationGetByIdEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class AccommodationUpdateEvent extends AccommodationEvent {
  final int id;
  final AccommodationRequestModel accommodationRequest;
  AccommodationUpdateEvent(this.id,this.accommodationRequest);
  @override
  List<Object?> get props => [id,accommodationRequest];
}

class AccommodationUpdate2Event extends AccommodationEvent {
  final int id;
  final AccommodationRequestModel accommodationRequest;
  AccommodationUpdate2Event(this.id,this.accommodationRequest);
  @override
  List<Object?> get props => [id,accommodationRequest];
}

class AccommodationPublishEvent extends AccommodationEvent {
  final double priceNight;
  final int id;
  final bool publish;
  AccommodationPublishEvent(this.id,this.priceNight,this.publish);
  @override
  List<Object?> get props => [id,priceNight,publish];
}