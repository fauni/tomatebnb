import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';

abstract class ExploreAccommodationState extends Equatable{
  @override
  List<Object> get props => [];
}

// Region: Accommodation Nearby
class GetAccommodationNearbyInitial extends ExploreAccommodationState{}
class GetAccommodationNearbyLoading extends ExploreAccommodationState{}
class GetAccommodationNearbySuccess extends ExploreAccommodationState{
  final List<AccommodationResponseCompleteModel> accommodations;
  GetAccommodationNearbySuccess(
    this.accommodations
  );
  @override
  List<Object> get props => [accommodations];
}

class GetAccommodationNearbyError extends ExploreAccommodationState{
  final String message;
  GetAccommodationNearbyError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

// EndRegion: Accommodation Nearby