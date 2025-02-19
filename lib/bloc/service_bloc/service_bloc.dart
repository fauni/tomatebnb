import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/service_repository.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRepository serviceRepository;

  ServiceBloc(this.serviceRepository) : super(ServiceInitial()){
    on<ServiceGetEvent>(_onServiceGet);
  }

  Future<void> _onServiceGet(ServiceGetEvent event, Emitter<ServiceState> emit) async {
    emit(ServiceGetLoading());
    try{
      final response = await serviceRepository.get();
      if(response.status){
        //await ServiceRepository.setUserData(response.data!);
        emit(ServiceGetSuccess(response.data!));
      } else {
        emit(ServiceGetError(response.message));
      }
    } catch(e){
      emit(ServiceGetError(e.toString()));
    }
  }
}