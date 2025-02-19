import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/service_response_model.dart';

abstract class ServiceState extends Equatable {
  @override
  List<Object> get props => [];
}
class ServiceInitial extends ServiceState {}

class ServiceGetLoading extends ServiceState {}

class ServiceGetSuccess extends ServiceState {
  final List<ServiceResponseModel> responseServices;
  ServiceGetSuccess(
    this.responseServices
  );
  @override
  List<Object> get props => [responseServices];
}

class ServiceGetError extends ServiceState {
  final String message;
  ServiceGetError(
    this.message
  );
  @override
  List<Object> get props => [message];
}