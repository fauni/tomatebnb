import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/describe_repository.dart';

class DescribeBloc extends Bloc<DescribeEvent, DescribeState> {
  final DescribeRepository describeRepository;

  DescribeBloc(this.describeRepository) : super(DescribeInitial()){
    on<DescribeGetEvent>(_onDescribeGet);
  }

  Future<void> _onDescribeGet(DescribeGetEvent event, Emitter<DescribeState> emit) async {
    emit(DescribeGetLoading());
    try{
      final response = await describeRepository.getByUser();
      if(response.status){
        //await DescribeRepository.setUserData(response.data!);
        emit(DescribeGetSuccess(response.data!));
      } else {
        emit(DescribeGetError(response.message));
      }
    } catch(e){
      emit(DescribeGetError(e.toString()));
    }
  }
}