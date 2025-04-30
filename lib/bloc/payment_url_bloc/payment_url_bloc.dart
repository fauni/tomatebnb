
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/payment_repository.dart';

class PaymentUrlBloc extends Bloc<PaymentUrlEvent, PaymentUrlState>{
  final PaymentRepository paymentRepository;

  PaymentUrlBloc(this.paymentRepository) : super(GenerateUrlPaymentInitial()){
    on<GenerateUrlPaymentEvent>(_onGenerateUrlPayment);
  }

  Future<void> _onGenerateUrlPayment(GenerateUrlPaymentEvent event, Emitter<PaymentUrlState> emit) async {
    emit(GenerateUrlPaymentLoading());
    try {
      final response = await paymentRepository.getUrlPayment(event.idReserva);
      if(response.status){
        emit(GenerateUrlPaymentSuccess(response.data!.mensaje!));
      } else {
        emit(GenerateUrlPaymentError(response.data!.mensaje!));
      }
    } catch (e){
      emit(GenerateUrlPaymentError(e.toString()));
    }
  }
}