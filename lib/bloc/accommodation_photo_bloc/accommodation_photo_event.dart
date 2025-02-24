
import 'package:equatable/equatable.dart';
import 'package:tomatebnb/models/accommodation/accommodation_photo_request_model.dart';
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

// class AccommodationPhotoDeleteEvent extends AccommodationPhotoEvent {
//   final int accommodationId, aspectId;
//   AccommodationPhotoDeleteEvent(this.accommodationId,this.aspectId);
//   @override
//   List<Object?> get props => [accommodationId, aspectId];
// }


