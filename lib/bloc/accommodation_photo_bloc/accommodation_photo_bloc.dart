import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/accommodation_photo_repository.dart';

class AccommodationPhotoBloc extends Bloc<AccommodationPhotoEvent, AccommodationPhotoState> {
  final AccommodationPhotoRepository accommodationPhotoRepository;

  AccommodationPhotoBloc(this.accommodationPhotoRepository) : super(AccommodationPhotoInitial()){
    // on<AccommodationPhotoGetEvent>(_onAccommodationPhotoGet);
    on<AccommodationPhotoCreateEvent>(_onAccommodationPhotoCreate);
    // on<AccommodationPhotoDeleteEvent>(_onAccommodationPhotoDelete);
    
  }

  // Future<void> _onAccommodationPhotoGet(AccommodationPhotoGetEvent event, Emitter<AccommodationPhotoState> emit) async {
  //   emit(AccommodationPhotoGetLoading());
  //   try{
  //     final response = await accommodationPhotoRepository.getbyAccommodation(event.accommodationId);
  //     if(response.status){
  //       //await DescribeRepository.setUserData(response.data!);
  //       emit(AccommodationPhotoGetSuccess(response.data!));
  //     } else {
  //       emit(AccommodationPhotoGetError(response.message));
  //     }
  //   } catch(e){
  //     emit(AccommodationPhotoGetError(e.toString()));
  //   }
  // }

     Future<void> _onAccommodationPhotoCreate(AccommodationPhotoCreateEvent event, Emitter<AccommodationPhotoState> emit) async {
    emit(AccommodationPhotoCreateLoading());
    try{
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: event.camera
                                                           ?ImageSource.camera
                                                           :ImageSource.gallery);
      File file = File(image!.path);                                                           
      final response = await accommodationPhotoRepository.createAccommodationPhoto(event.accommodationPhotoRequest,file);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationPhotoCreateSuccess(response.data!));
      } else {
        emit(AccommodationPhotoCreateError(response.message));
      }
    } catch(e){
      emit(AccommodationPhotoCreateError(e.toString()));
      
    }
  }

  // Future<void> _onAccommodationPhotoDelete(AccommodationPhotoDeleteEvent event, Emitter<AccommodationPhotoState> emit) async {
  //   emit(AccommodationPhotoDeleteLoading());
  //   try{
  //     final response = await accommodationPhotoRepository.delete(event.accommodationId,event.aspectId);
  //     if(response.status){
  //       //await accommodationRepository.setUserData(response.data!);
  //       emit(AccommodationPhotoDeleteSuccess(response.data!));
  //     } else {
  //       emit(AccommodationPhotoDeleteError(response.message));
  //     }
  //   } catch(e){
  //     emit(AccommodationPhotoDeleteError(e.toString()));
  //   }
  // }
}