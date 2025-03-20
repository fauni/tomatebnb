import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';

abstract class ExploreAccommodationDetailState extends Equatable{
  @override
  List<Object> get props => [];
}


// Region: Accommodation Nearby
class GetAccommodationDetailInitial extends ExploreAccommodationDetailState{}
class GetAccommodationDetailLoading extends ExploreAccommodationDetailState{}
class GetAccommodationDetailSuccess extends ExploreAccommodationDetailState{
  final AccommodationResponseCompleteModel accommodation;
  GetAccommodationDetailSuccess(
    this.accommodation
  );
  @override
  List<Object> get props => [accommodation];
}

class GetAccommodationDetailError extends ExploreAccommodationDetailState{
  final String message;
  GetAccommodationDetailError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

// EndRegion: Accommodation Nearby