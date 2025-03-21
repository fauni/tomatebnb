import 'package:equatable/equatable.dart';

abstract class ExploreAccommodationDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAccommodationByIdEvent extends ExploreAccommodationDetailEvent {
  GetAccommodationByIdEvent(this.id);
  final int id;
  @override
  List<Object> get props => [id];
}
