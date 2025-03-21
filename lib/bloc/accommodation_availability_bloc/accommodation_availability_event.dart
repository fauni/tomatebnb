
import 'package:equatable/equatable.dart';
abstract class AccommodationAvailabilityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccommodationAvailabilityGetEvent extends AccommodationAvailabilityEvent {
  final int accommodationId;
  AccommodationAvailabilityGetEvent(this.accommodationId);
  @override
  List<Object?> get props => [accommodationId];
}



