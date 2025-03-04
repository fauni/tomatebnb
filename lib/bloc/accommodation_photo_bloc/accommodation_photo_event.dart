
import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_photo_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_photo_response_model.dart';
abstract class AccommodationPhotoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// class AccommodationPhotoGetEvent extends AccommodationPhotoEvent {
//   final int accommodationId;
//   AccommodationPhotoGetEvent(this.accommodationId);
//   @override
//   List<Object?> get props => [accommodationId];
// }

class AccommodationPhotoCreateEvent extends AccommodationPhotoEvent {
  final AccommodationPhotoRequestModel accommodationPhotoRequest;
  final bool camera ;
  AccommodationPhotoCreateEvent(this.accommodationPhotoRequest,this.camera);
  @override
  List<Object?> get props => [accommodationPhotoRequest,camera];
}

class AccommodationPhotoDeleteEvent extends AccommodationPhotoEvent {
  final int photoId;
  AccommodationPhotoDeleteEvent(this.photoId);
  @override
  List<Object?> get props => [photoId];
}

class AccommodationPhotoUpdateEvent extends AccommodationPhotoEvent {
  final int id;
  final AccommodationPhotoResponseModel accommodationRequest;
  AccommodationPhotoUpdateEvent(this.id,this.accommodationRequest);
  @override
  List<Object?> get props => [id,accommodationRequest];
}

class AccommodationPhotoGetMainByAccommodationEvent extends AccommodationPhotoEvent {
  final int id;
  AccommodationPhotoGetMainByAccommodationEvent(this.id);
  @override
  List<Object?> get props => [id];
}


