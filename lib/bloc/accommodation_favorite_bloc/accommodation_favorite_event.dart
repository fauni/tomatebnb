import 'package:equatable/equatable.dart';

abstract class AccommodationFavoriteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAccommodationFavoriteEvent extends AccommodationFavoriteEvent {
  GetAccommodationFavoriteEvent();
  @override
  List<Object> get props => [];
}

class AddAccommodationFavoriteEvent extends AccommodationFavoriteEvent {
  final int accommodationId;
  AddAccommodationFavoriteEvent(this.accommodationId);
  @override
  List<Object> get props => [accommodationId];
}
class RemoveAccommodationFavoriteEvent extends AccommodationFavoriteEvent {
  final int accommodationId;
  RemoveAccommodationFavoriteEvent(this.accommodationId);
  @override
  List<Object> get props => [accommodationId];
}