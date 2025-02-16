import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/describe_response_model.dart';

abstract class DescribeState extends Equatable {
  @override
  List<Object> get props => [];
}
class DescribeInitial extends DescribeState {}

class DescribeGetLoading extends DescribeState {}

class DescribeGetSuccess extends DescribeState {
  final List<DescribeResponseModel> responseDescribes;
  DescribeGetSuccess(
    this.responseDescribes
  );
  @override
  List<Object> get props => [responseDescribes];
}

class DescribeGetError extends DescribeState {
  final String message;
  DescribeGetError(
    this.message
  );
  @override
  List<Object> get props => [message];
}