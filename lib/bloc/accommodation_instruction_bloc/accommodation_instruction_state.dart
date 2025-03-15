import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_instruction_response_model.dart';

abstract class AccommodationInstructionState extends Equatable {
  @override
  List<Object> get props => [];
}
class AccommodationInstructionInitial extends AccommodationInstructionState {}

//estados para obtener insdtrucciones de alojamiento 
class AccommodationInstructionGetByAccommodationLoading extends AccommodationInstructionState {}

class AccommodationInstructionGetByAccommodationSuccess extends AccommodationInstructionState {
  final List<AccommodationInstructionResponseModel> responseAccommodationInstructions;
  AccommodationInstructionGetByAccommodationSuccess(
    this.responseAccommodationInstructions
  );
  @override
  List<Object> get props => [responseAccommodationInstructions];
}

class AccommodationInstructionGetByAccommodationError extends AccommodationInstructionState {
  final String message;
  AccommodationInstructionGetByAccommodationError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//Estados para actualizar descripcion de la instruction  de alojamiento por id
class AccommodationInstructionUpdateLoading extends AccommodationInstructionState {}

class AccommodationInstructionUpdateSuccess extends AccommodationInstructionState {
  final bool status;
  AccommodationInstructionUpdateSuccess(
    this.status
  );
  @override
  List<Object> get props => [status];
}

class AccommodationInstructionUpdateError extends AccommodationInstructionState {
  final String message;
  AccommodationInstructionUpdateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}
