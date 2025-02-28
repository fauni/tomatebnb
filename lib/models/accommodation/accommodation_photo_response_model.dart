// To parse this JSON data, do
//
//     final accommodationPhotoResponseModel = accommodationPhotoResponseModelFromJson(jsonString);

import 'dart:convert';

class AccommodationPhotosResponseModel {
  List<AccommodationPhotoResponseModel> items = [];
  AccommodationPhotosResponseModel();
  AccommodationPhotosResponseModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationPhotoResponse = AccommodationPhotoResponseModel.fromJson(item);
        items.add(accommodationPhotoResponse);
      } 
    }
  }
}

AccommodationPhotoResponseModel accommodationPhotoResponseModelFromJson(String str) => AccommodationPhotoResponseModel.fromJson(json.decode(str));

String accommodationPhotoResponseModelToJson(AccommodationPhotoResponseModel data) => json.encode(data.toJson());

class AccommodationPhotoResponseModel {
    int accommodationId;
    String photoUrl;
    bool mainPhoto;
    int order;
    // String status;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    AccommodationPhotoResponseModel({
        required this.accommodationId,
        required this.photoUrl,
        required this.mainPhoto,
        required this.order,
        // required this.status,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory AccommodationPhotoResponseModel.fromJson(Map<String, dynamic> json) => AccommodationPhotoResponseModel(
        accommodationId: int.parse(json["accommodation_id"].toString()),
        photoUrl: json["photo_url"],
        mainPhoto: json["mainPhoto"]=='1'?true:false,
        order: int.parse(json["order"].toString()) ,
        // status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "accommodation_id": accommodationId,
        "photo_url": photoUrl,
        "mainPhoto": mainPhoto,
        "order": order,
        // "status": status,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
