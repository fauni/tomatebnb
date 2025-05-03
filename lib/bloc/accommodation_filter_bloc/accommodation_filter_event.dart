import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_filter_request.dart';

abstract class AccommodationFilterEvent extends Equatable{
  const AccommodationFilterEvent();

  @override
  List<Object> get props => [];
}

class FilterAccommodationsEvent extends AccommodationFilterEvent {
  final AccommodationFilterRequest request;

  const FilterAccommodationsEvent(this.request);

  @override
  List<Object> get props => [request];
}