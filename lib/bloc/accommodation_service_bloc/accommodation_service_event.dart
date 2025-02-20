
import 'package:equatable/equatable.dart';
abstract class AccommodationServiceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccommodationServiceGetEvent extends AccommodationServiceEvent {
  final int accommodationId;
  AccommodationServiceGetEvent(this.accommodationId);
  @override
  List<Object?> get props => [accommodationId];
}

class AccommodationServiceCreateEvent extends AccommodationServiceEvent {
  final int accommodationId, serviceId;
  AccommodationServiceCreateEvent(this.accommodationId,this.serviceId);
  @override
  List<Object?> get props => [accommodationId, serviceId];
}

class AccommodationServiceDeleteEvent extends AccommodationServiceEvent {
  final int accommodationId, serviceId;
  AccommodationServiceDeleteEvent(this.accommodationId,this.serviceId);
  @override
  List<Object?> get props => [accommodationId, serviceId];
}


