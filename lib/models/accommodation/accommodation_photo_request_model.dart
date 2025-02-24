// To parse this JSON data, do
//
//     final accommodationPhotoRequestModel = accommodationPhotoRequestModelFromJson(jsonString);

import 'dart:convert';

class AccommodationPhotosRequestModel {
  List<AccommodationPhotoRequestModel> items = [];
  AccommodationPhotosRequestModel();
  AccommodationPhotosRequestModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationPhotoRequest = AccommodationPhotoRequestModel.fromJson(item);
        items.add(accommodationPhotoRequest);
      } 
    }
  }
}

AccommodationPhotoRequestModel accommodationPhotoRequestModelFromJson(String str) => AccommodationPhotoRequestModel.fromJson(json.decode(str));

String accommodationPhotoRequestModelToJson(AccommodationPhotoRequestModel data) => json.encode(data.toJson());

class AccommodationPhotoRequestModel {
    String accommodationId;
    String photoUrl;
    String mainPhoto;
    String order;
    AccommodationPhotoRequestModel({
        required this.accommodationId,
        required this.photoUrl,
        required this.mainPhoto,
        required this.order,
       
    });

    factory AccommodationPhotoRequestModel.fromJson(Map<String, dynamic> json) => AccommodationPhotoRequestModel(
        accommodationId: json["accommodation_id"],
        photoUrl: json["photo_url"],
        mainPhoto: json["mainPhoto"],
        order: json["order"],
        
    );

    Map<String, dynamic> toJson() => {
        "accommodation_id": accommodationId,
        "photo_url": photoUrl,
        "mainPhoto": mainPhoto,
        "order": order,
      
    };
}
