import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';

abstract class AccommodationFilterState extends Equatable{
  const AccommodationFilterState();

  @override
  List<Object> get props => [];
}

class AccommodationFilterInitial extends AccommodationFilterState {}

class AccommodationFilterLoading extends AccommodationFilterState {}

class AccommodationFilterLoaded extends AccommodationFilterState {
  final List<AccommodationResponseCompleteModel> accommodations;

  const AccommodationFilterLoaded(this.accommodations);

  @override
  List<Object> get props => [accommodations];
}

class AccommodationFilterError extends AccommodationFilterState {
  final String message;

  const AccommodationFilterError(this.message);

  @override
  List<Object> get props => [message];
}