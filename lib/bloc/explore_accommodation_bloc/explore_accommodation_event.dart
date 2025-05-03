import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_filter_request.dart';

abstract class ExploreAccommodationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NearbyAccommodationGetEvent extends ExploreAccommodationEvent {
  NearbyAccommodationGetEvent();
  @override
  List<Object> get props => [];
}

class GetAccommodationByDescribeEvent extends ExploreAccommodationEvent {
  final int describeId;
  GetAccommodationByDescribeEvent(this.describeId);
  @override
  List<Object> get props => [describeId];
}

class GetAccommodationByFilterEvent extends ExploreAccommodationEvent {
  final AccommodationFilterRequest request;
  GetAccommodationByFilterEvent(this.request);
  @override
  List<Object> get props => [request];
  
}