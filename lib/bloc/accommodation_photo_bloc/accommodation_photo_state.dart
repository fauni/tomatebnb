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

//estados para guardar servicios de alojamiento
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

//estados para eliminar servicios de alojamiento
// class AccommodationPhotoDeleteLoading extends AccommodationPhotoState {}

// class AccommodationPhotoDeleteSuccess extends AccommodationPhotoState {
//   final AccommodationPhotoResponseModel responseAccommodationPhoto;
//   AccommodationPhotoDeleteSuccess(
//     this.responseAccommodationPhoto
//   );
//   @override
//   List<Object> get props => [responseAccommodationPhoto];
// }

// class AccommodationPhotoDeleteError extends AccommodationPhotoState {
//   final String message;
//   AccommodationPhotoDeleteError(
//     this.message
//   );
//   @override
//   List<Object> get props => [message];
// }