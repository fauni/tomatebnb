// To parse this JSON data, do
//
//     final accommodationAspectRequestModel = accommodationAspectRequestModelFromJson(jsonString);

import 'dart:convert';

class AccommodationAspectsRequestModel {
  List<AccommodationAspectRequestModel> items = [];
  AccommodationAspectsRequestModel();
  AccommodationAspectsRequestModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationServiceRequest = AccommodationAspectRequestModel.fromJson(item);
        items.add(accommodationServiceRequest);
      } 
    }
  }
}

AccommodationAspectRequestModel accommodationAspectRequestModelFromJson(String str) => AccommodationAspectRequestModel.fromJson(json.decode(str));

String accommodationAspectRequestModelToJson(AccommodationAspectRequestModel data) => json.encode(data.toJson());

class AccommodationAspectRequestModel {
    int accommodationId;
    int aspectId;
    bool status;

    AccommodationAspectRequestModel({
        required this.accommodationId,
        required this.aspectId,
        required this.status,
    });

    factory AccommodationAspectRequestModel.fromJson(Map<String, dynamic> json) => AccommodationAspectRequestModel(
        accommodationId: json["accommodation_id"],
        aspectId: json["aspect_id"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "accommodation_id": accommodationId,
        "aspect_id": aspectId,
        "status": status,
    };
}
