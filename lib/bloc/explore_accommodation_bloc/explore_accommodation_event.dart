import 'package:equatable/equatable.dart';

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