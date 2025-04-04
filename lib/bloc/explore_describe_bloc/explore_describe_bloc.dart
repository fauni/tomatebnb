import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/describe_repository.dart';

class ExploreDescribeBloc extends Bloc<ExploreDescribeEvent, ExploreDescribeState> {
  final DescribeRepository describeRepository;
  ExploreDescribeBloc(this.describeRepository) : super(DescribesForExploreInitial()) {
    on<GetDescribesForExploreEvent>(_onGetDescribesForExplore);
  }
  
  Future<void> _onGetDescribesForExplore(GetDescribesForExploreEvent event, Emitter<ExploreDescribeState> emit) async {
    emit(DescribesForExploreLoading());
    try {
      final response = await describeRepository.handleGetDescribesForExplore();
      if (response.status) {
        emit(DescribesForExploreSuccess(response.data!));
      } else {
        emit(DescribesForExploreError(response.message));
      }
    } catch (e) {
      emit(DescribesForExploreError(e.toString()));
    }
  }
}