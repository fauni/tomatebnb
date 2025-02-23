import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/aspect_response_model.dart';

abstract class AspectState extends Equatable {
  @override
  List<Object> get props => [];
}
class AspectInitial extends AspectState {}


class AspectGetByDescribeLoading extends AspectState {}

class AspectGetByDescribeSuccess extends AspectState {
  final List<AspectResponseModel> responseAspects;
  AspectGetByDescribeSuccess(
    this.responseAspects
  );
  @override
  List<Object> get props => [responseAspects];
}

class AspectGetByDescribeError extends AspectState {
  final String message;
  AspectGetByDescribeError(
    this.message
  );
  @override
  List<Object> get props => [message];
}