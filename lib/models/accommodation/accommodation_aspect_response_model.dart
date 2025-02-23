// To parse this JSON data, do
//
//     final accommodationAspectResponseModel = accommodationAspectResponseModelFromJson(jsonString);

import 'dart:convert';

class AccommodationAspectsResponseModel {
  List<AccommodationAspectResponseModel> items = [];
  AccommodationAspectsResponseModel();
  AccommodationAspectsResponseModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationServiceResponse = AccommodationAspectResponseModel.fromJson(item);
        items.add(accommodationServiceResponse);
      } 
    }
  }
}

// To parse this JSON data, do
//
//     final accommodationAspectResponseModel = accommodationAspectResponseModelFromJson(jsonString);

AccommodationAspectResponseModel accommodationAspectResponseModelFromJson(String str) => AccommodationAspectResponseModel.fromJson(json.decode(str));

String accommodationAspectResponseModelToJson(AccommodationAspectResponseModel data) => json.encode(data.toJson());

class AccommodationAspectResponseModel {
    int accommodationId;
    int aspectId;
    bool status;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    AccommodationAspectResponseModel({
        required this.accommodationId,
        required this.aspectId,
        required this.status,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory AccommodationAspectResponseModel.fromJson(Map<String, dynamic> json) => AccommodationAspectResponseModel(
        accommodationId: json["accommodation_id"],
        aspectId: json["aspect_id"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "accommodation_id": accommodationId,
        "aspect_id": aspectId,
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
