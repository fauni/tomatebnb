import 'package:equatable/equatable.dart';
// import 'package:tomatebnb/models/accommodation/describe_response_model.dart';

abstract class LocalizationState extends Equatable {
  @override
  List<Object> get props => [];
}
class LocalizationInitial extends LocalizationState {}

class LocalizationGetLoading extends LocalizationState {}

class LocalizationGetSuccess extends LocalizationState {
  final double  latitude;
  final double longitude;
  LocalizationGetSuccess(
    this.latitude,
    this.longitude
  );
  @override
  List<Object> get props => [latitude, longitude];
}

class LocalizationGetError extends LocalizationState {
  final String message;
  LocalizationGetError(
    this.message
  );
  @override
  List<Object> get props => [message];
}