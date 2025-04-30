import 'package:equatable/equatable.dart';

abstract class PaymentUrlState extends Equatable{
  @override
  List<Object> get props => [];
}

class GenerateUrlPaymentInitial extends PaymentUrlState {}

class GenerateUrlPaymentLoading extends PaymentUrlState {}

class GenerateUrlPaymentSuccess extends PaymentUrlState {
  final String url;
  GenerateUrlPaymentSuccess(this.url);
  @override
  List<Object> get props => [url];
}

class GenerateUrlPaymentError extends PaymentUrlState {
  final String message;
  GenerateUrlPaymentError(this.message);
  @override
  List<Object> get props => [message];
}

