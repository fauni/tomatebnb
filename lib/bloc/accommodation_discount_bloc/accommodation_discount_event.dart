
import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_discount_request_model.dart';
abstract class AccommodationDiscountEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccommodationDiscountGetByAccommodationEvent extends AccommodationDiscountEvent {
  final int accommodationId;
  AccommodationDiscountGetByAccommodationEvent(this.accommodationId);
  @override
  List<Object?> get props => [accommodationId];
}

class AccommodationDiscountCreateEvent extends AccommodationDiscountEvent {
  final AccommodationDiscountRequestModel accommodationDiscountRequest;
  AccommodationDiscountCreateEvent(this.accommodationDiscountRequest);
  @override
  List<Object?> get props => [accommodationDiscountRequest];
}

class AccommodationDiscountDeleteEvent extends AccommodationDiscountEvent {
  final int priceId;
  AccommodationDiscountDeleteEvent(this.priceId);
  @override
  List<Object?> get props => [priceId];
}

class AccommodationDiscountUpdateEvent extends AccommodationDiscountEvent {
  final int id;
  final AccommodationDiscountRequestModel accommodationDiscountRequest;
  AccommodationDiscountUpdateEvent(this.id,this.accommodationDiscountRequest);
  @override
  List<Object?> get props => [id,accommodationDiscountRequest];
}


