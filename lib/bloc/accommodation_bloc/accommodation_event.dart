
import 'package:equatable/equatable.dart';
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