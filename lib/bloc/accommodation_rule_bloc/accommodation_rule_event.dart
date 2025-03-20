
import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_rule_request_model.dart';
abstract class AccommodationRuleEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccommodationRuleGetByAccommodationEvent extends AccommodationRuleEvent {
  final int accommodationId;
  AccommodationRuleGetByAccommodationEvent(this.accommodationId);
  @override
  List<Object?> get props => [accommodationId];
}

class AccommodationRuleCreateEvent extends AccommodationRuleEvent {
  final AccommodationRuleRequestModel accommodationRuleRequest;
  AccommodationRuleCreateEvent(this.accommodationRuleRequest);
  @override
  List<Object?> get props => [accommodationRuleRequest];
}

class AccommodationRuleUpdateEvent extends AccommodationRuleEvent {
  final int id;
  final AccommodationRuleRequestModel accommodationRuleRequest;
  AccommodationRuleUpdateEvent(this.id,this.accommodationRuleRequest);
  @override
  List<Object?> get props => [id,accommodationRuleRequest];
}

class AccommodationRuleDeleteEvent extends AccommodationRuleEvent {
  final int ruleId;
  AccommodationRuleDeleteEvent(this.ruleId);
  @override
  List<Object?> get props => [ruleId];
}


