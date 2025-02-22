
import 'package:equatable/equatable.dart';
abstract class AccommodationAspectEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccommodationAspectGetEvent extends AccommodationAspectEvent {
  final int accommodationId;
  AccommodationAspectGetEvent(this.accommodationId);
  @override
  List<Object?> get props => [accommodationId];
}

class AccommodationAspectCreateEvent extends AccommodationAspectEvent {
  final int accommodationId, aspectId;
  AccommodationAspectCreateEvent(this.accommodationId,this.aspectId);
  @override
  List<Object?> get props => [accommodationId, aspectId];
}

class AccommodationAspectDeleteEvent extends AccommodationAspectEvent {
  final int accommodationId, aspectId;
  AccommodationAspectDeleteEvent(this.accommodationId,this.aspectId);
  @override
  List<Object?> get props => [accommodationId, aspectId];
}


