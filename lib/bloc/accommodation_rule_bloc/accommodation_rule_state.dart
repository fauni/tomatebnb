import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_rule_response_model.dart';


abstract class AccommodationRuleState extends Equatable {
  @override
  List<Object> get props => [];
}
class AccommodationRuleInitial extends AccommodationRuleState {}

//estados para obtener reglas de alojamiento 
class AccommodationRuleGetByAccommodationLoading extends AccommodationRuleState {}

class AccommodationRuleGetByAccommodationSuccess extends AccommodationRuleState {
  final List<AccommodationRuleResponseModel> responseAccommodationRules;
  AccommodationRuleGetByAccommodationSuccess(
    this.responseAccommodationRules
  );
  @override
  List<Object> get props => [responseAccommodationRules];
}

class AccommodationRuleGetByAccommodationError extends AccommodationRuleState {
  final String message;
  AccommodationRuleGetByAccommodationError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//estados para guardar reglas de alojamiento
class AccommodationRuleCreateLoading extends AccommodationRuleState {}

class AccommodationRuleCreateSuccess extends AccommodationRuleState {
  final AccommodationRuleResponseModel responseAccommodationRule;
  AccommodationRuleCreateSuccess(
    this.responseAccommodationRule
  );
  @override
  List<Object> get props => [responseAccommodationRule];
}

class AccommodationRuleCreateError extends AccommodationRuleState {
  final String message;
  AccommodationRuleCreateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}


//Estados para actualizar regla de alojamiento por id
class AccommodationRuleUpdateLoading extends AccommodationRuleState {}

class AccommodationRuleUpdateSuccess extends AccommodationRuleState {
  final bool status;
  AccommodationRuleUpdateSuccess(
    this.status
  );
  @override
  List<Object> get props => [status];
}

class AccommodationRuleUpdateError extends AccommodationRuleState {
  final String message;
  AccommodationRuleUpdateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//estados para eliminar reglas de alojamiento
class AccommodationRuleDeleteLoading extends AccommodationRuleState {}

class AccommodationRuleDeleteSuccess extends AccommodationRuleState {
  final AccommodationRuleResponseModel responseAccommodationRule;
  AccommodationRuleDeleteSuccess(
    this.responseAccommodationRule
  );
  @override
  List<Object> get props => [responseAccommodationRule];
}

class AccommodationRuleDeleteError extends AccommodationRuleState {
  final String message;
  AccommodationRuleDeleteError(
    this.message
  );
  @override
  List<Object> get props => [message];
}
