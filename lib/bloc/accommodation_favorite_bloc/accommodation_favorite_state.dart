import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/models/explore/describe.dart';

abstract class AccommodationFavoriteState extends Equatable {
  @override
  List<Object> get props => [];
}

class AccommodationFavoriteInitial extends AccommodationFavoriteState{}
class AccommodationFavoriteLoading extends AccommodationFavoriteState{}
class AccommodationFavoriteLoaded extends AccommodationFavoriteState{
  final List<AccommodationResponseCompleteModel> accommodationList;
  AccommodationFavoriteLoaded(this.accommodationList);
  @override
  List<Object> get props => [accommodationList];
}
class AccommodationFavoriteError extends AccommodationFavoriteState{
  final String message;
  AccommodationFavoriteError(this.message);
  @override
  List<Object> get props => [message];
}