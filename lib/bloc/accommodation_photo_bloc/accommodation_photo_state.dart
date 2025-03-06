import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_photo_response_model.dart';


abstract class AccommodationPhotoState extends Equatable {
  @override
  List<Object> get props => [];
}
class AccommodationPhotoInitial extends AccommodationPhotoState {}

//estados para obtener servicios de alojamiento
// class AccommodationPhotoGetLoading extends AccommodationPhotoState {}

// class AccommodationPhotoGetSuccess extends AccommodationPhotoState {
//   final List<AccommodationPhotoResponseModel> responseAccommodationPhotos;
//   AccommodationPhotoGetSuccess(
//     this.responseAccommodationPhotos
//   );
//   @override
//   List<Object> get props => [responseAccommodationPhotos];
// }

// class AccommodationPhotoGetError extends AccommodationPhotoState {
//   final String message;
//   AccommodationPhotoGetError(
//     this.message
//   );
//   @override
//   List<Object> get props => [message];
// }

//estados para crear foto de alojamiento
class AccommodationPhotoCreateLoading extends AccommodationPhotoState {}

class AccommodationPhotoCreateSuccess extends AccommodationPhotoState {
  final AccommodationPhotoResponseModel responseAccommodationPhoto;
  AccommodationPhotoCreateSuccess(
    this.responseAccommodationPhoto
  );
  @override
  List<Object> get props => [responseAccommodationPhoto];
}

class AccommodationPhotoCreateError extends AccommodationPhotoState {
  final String message;
  AccommodationPhotoCreateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//estados para eliminar foto de alojamiento
class AccommodationPhotoDeleteLoading extends AccommodationPhotoState {}

class AccommodationPhotoDeleteSuccess extends AccommodationPhotoState {
  final AccommodationPhotoResponseModel responseAccommodationPhoto;
  AccommodationPhotoDeleteSuccess(
    this.responseAccommodationPhoto
  );
  @override
  List<Object> get props => [responseAccommodationPhoto];
}

class AccommodationPhotoDeleteError extends AccommodationPhotoState {
  final String message;
  AccommodationPhotoDeleteError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//Estados para actualizar registro de la foto de alojamiento por id
class AccommodationPhotoUpdateLoading extends AccommodationPhotoState {}

class AccommodationPhotoUpdateSuccess extends AccommodationPhotoState {
  final bool status;
  AccommodationPhotoUpdateSuccess(
    this.status
  );
  @override
  List<Object> get props => [status];
}

class AccommodationPhotoUpdateError extends AccommodationPhotoState {
  final String message;
  AccommodationPhotoUpdateError(
    this.message
  );
  @override
  List<Object> get props => [message];
}

//Estados para obtencion de foto Principal de alojamiento por id de alojamiento
class AccommodationPhotoGetMainByAccommodationLoading extends AccommodationPhotoState {}

class AccommodationPhotoGetMainByAccommodationSuccess extends AccommodationPhotoState {
  final AccommodationPhotoResponseModel responseAccommodationPhoto;
  AccommodationPhotoGetMainByAccommodationSuccess(
    this.responseAccommodationPhoto
  );
  @override
  List<Object> get props => [responseAccommodationPhoto];
}

class AccommodationPhotoGetMainByAccommodationError extends AccommodationPhotoState {
  final String message;
  AccommodationPhotoGetMainByAccommodationError(
    this.message
  );
  @override
  List<Object> get props => [message];
}
