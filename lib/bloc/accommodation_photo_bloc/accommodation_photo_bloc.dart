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
     on<AccommodationPhotoDeleteEvent>(_onAccommodationPhotoDelete);
     on<AccommodationPhotoUpdateEvent>(_onAccommodationPhotoUpdate);
     on<AccommodationPhotoGetMainByAccommodationEvent>(_onAccommodationPhotoGetMainByAccommodation);
     
    
  }

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

  Future<void> _onAccommodationPhotoDelete(AccommodationPhotoDeleteEvent event, Emitter<AccommodationPhotoState> emit) async {
    emit(AccommodationPhotoDeleteLoading());
    try{
      final response = await accommodationPhotoRepository.delete(event.photoId);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationPhotoDeleteSuccess(response.data!));
      } else {
        emit(AccommodationPhotoDeleteError(response.message));
      }
    } catch(e){
      emit(AccommodationPhotoDeleteError(e.toString()));
    }
  }

  Future<void> _onAccommodationPhotoUpdate(AccommodationPhotoUpdateEvent event, Emitter<AccommodationPhotoState> emit) async {
    emit(AccommodationPhotoUpdateLoading());
    try{
      final response = await accommodationPhotoRepository.update(event.id,event.accommodationRequest);
      if(response.status){
        //await accommodationRepository.setUserData(response.data!);
        emit(AccommodationPhotoUpdateSuccess(response.status));
      } else {
        emit(AccommodationPhotoUpdateError(response.message));
      }
    } catch(e){
      emit(AccommodationPhotoUpdateError(e.toString()));
    }
  }

  Future<void> _onAccommodationPhotoGetMainByAccommodation(AccommodationPhotoGetMainByAccommodationEvent event, Emitter<AccommodationPhotoState> emit) async {
    emit(AccommodationPhotoGetMainByAccommodationLoading());
    try{
      final response = await accommodationPhotoRepository.getMainByAccommodation(event.id);
      if(response.status){
        //await DescribeRepository.setUserData(response.data!);
        emit(AccommodationPhotoGetMainByAccommodationSuccess(response.data!));
      } else {
        emit(AccommodationPhotoGetMainByAccommodationError(response.message));
      }
    } catch(e){
      emit(AccommodationPhotoGetMainByAccommodationError(e.toString()));
    }
  }
}