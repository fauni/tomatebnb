
import 'package:equatable/equatable.dart';

abstract class AccommodationInstructionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccommodationInstructionGetByAccommodationEvent extends AccommodationInstructionEvent {
  final int accommodationId;
  AccommodationInstructionGetByAccommodationEvent(this.accommodationId);
  @override
  List<Object?> get props => [accommodationId];
}

class AccommodationInstructionUpdateEvent extends AccommodationInstructionEvent {
  final int id;
  final String description;
  AccommodationInstructionUpdateEvent(this.id,this.description);
  @override
  List<Object?> get props => [id,description];
}



