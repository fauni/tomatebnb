import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/reserve_respository.dart';

class ReserveBloc extends Bloc<ReserveEvent, ReserveState> {
  final ReserveRepository reserveRepository;

  ReserveBloc(this.reserveRepository) : super(ReserveInitial()){
    on<ReserveCreateEvent>(_onReserveCreate);
  }

     Future<void> _onReserveCreate(ReserveCreateEvent event, Emitter<ReserveState> emit) async {
    emit(ReserveCreateLoading());
    try{
      final response = await reserveRepository.createReserve(event.requestModel);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(ReserveCreateSuccess(response.data!));
      } else {
        emit(ReserveCreateError(response.message));
      }
    } catch(e){
      emit(ReserveCreateError(e.toString()));
      
    }
  }

}