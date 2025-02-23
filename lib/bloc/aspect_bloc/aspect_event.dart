import 'package:equatable/equatable.dart';
abstract class AspectEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AspectGetByDescribeEvent extends AspectEvent {
  final int describeId;
  AspectGetByDescribeEvent(this.describeId);
  @override
  List<Object?> get props => [describeId];
}

