
import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_price_request_model.dart';
abstract class AccommodationPriceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccommodationPriceGetByAccommodationEvent extends AccommodationPriceEvent {
  final int accommodationId;
  AccommodationPriceGetByAccommodationEvent(this.accommodationId);
  @override
  List<Object?> get props => [accommodationId];
}

class AccommodationPriceCreateEvent extends AccommodationPriceEvent {
  final AccommodationPriceRequestModel accommodationPriceRequest;
  AccommodationPriceCreateEvent(this.accommodationPriceRequest);
  @override
  List<Object?> get props => [accommodationPriceRequest];
}

class AccommodationPriceDeleteEvent extends AccommodationPriceEvent {
  final int priceId;
  AccommodationPriceDeleteEvent(this.priceId);
  @override
  List<Object?> get props => [priceId];
}

class AccommodationPriceUpdateEvent extends AccommodationPriceEvent {
  final int id;
  final AccommodationPriceRequestModel accommodationPriceRequest;
  AccommodationPriceUpdateEvent(this.id,this.accommodationPriceRequest);
  @override
  List<Object?> get props => [id,accommodationPriceRequest];
}


