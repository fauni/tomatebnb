import 'package:equatable/equatable.dart';

abstract class PaymentUrlEvent extends Equatable{
  List<Object> get props => [];
}

class GenerateUrlPaymentEvent extends PaymentUrlEvent {
  final int idReserva;
  GenerateUrlPaymentEvent(this.idReserva);
  @override
  List<Object> get props => [idReserva];
}

