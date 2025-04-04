import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/explore/describe.dart';

abstract class ExploreDescribeState extends Equatable {
  @override
  List<Object> get props => [];
}

class DescribesForExploreInitial extends ExploreDescribeState{}
class DescribesForExploreLoading extends ExploreDescribeState{}
class DescribesForExploreSuccess extends ExploreDescribeState{
  final List<Describe> describes;
  DescribesForExploreSuccess(this.describes);
  @override
  List<Object> get props => [describes];
}
class DescribesForExploreError extends ExploreDescribeState{
  final String message;
  DescribesForExploreError(this.message);
  @override
  List<Object> get props => [message];
}