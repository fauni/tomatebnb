import 'package:equatable/equatable.dart';
abstract class ServiceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServiceGetEvent extends ServiceEvent {
  ServiceGetEvent();
  @override
  List<Object?> get props => [];
}

class ServiceCreateEvent extends ServiceEvent {
  ServiceCreateEvent();
  @override
  List<Object?> get props => [];
}