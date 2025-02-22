import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/aspect_repository.dart';

class AspectBloc extends Bloc<AspectEvent, AspectState> {
  final AspectRepository aspectRepository;

  AspectBloc(this.aspectRepository) : super(AspectInitial()){
    on<AspectGetByDescribeEvent>(_onAspectGetByDescribe);
  }

  Future<void> _onAspectGetByDescribe(AspectGetByDescribeEvent event, Emitter<AspectState> emit) async {
    emit(AspectGetByDescribeLoading());
    try{
      final response = await aspectRepository.getBydescribe(event.describeId);
      if(response.status){
        //await AspectRepository.setUserData(response.data!);
        emit(AspectGetByDescribeSuccess(response.data!));
      } else {
        emit(AspectGetByDescribeError(response.message));
      }
    } catch(e){
      emit(AspectGetByDescribeError(e.toString()));
    }
  }
}