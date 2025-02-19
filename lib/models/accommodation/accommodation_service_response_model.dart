// To parse this JSON data, do
//
//     final accommodationServiceResponseModel = accommodationServiceResponseModelFromJson(jsonString);

import 'dart:convert';

class AccommodationServicesResponseModel {
  List<AccommodationServiceResponseModel> items = [];
  AccommodationServicesResponseModel();
  AccommodationServicesResponseModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationServiceResponse = AccommodationServiceResponseModel.fromJson(item);
        items.add(accommodationServiceResponse);
      } 
    }
  }
}


AccommodationServiceResponseModel accommodationServiceResponseModelFromJson(String str) => AccommodationServiceResponseModel.fromJson(json.decode(str));

String accommodationServiceResponseModelToJson(AccommodationServiceResponseModel data) => json.encode(data.toJson());

class AccommodationServiceResponseModel {
    int id;
    int accommodationId;
    int serviceId;
    bool status;
    DateTime updatedAt;
    DateTime createdAt;

    AccommodationServiceResponseModel({
        required this.id,
        required this.accommodationId,
        required this.serviceId,
        required this.status,
        required this.updatedAt,
        required this.createdAt,
    });

    factory AccommodationServiceResponseModel.fromJson(Map<String, dynamic> json) => AccommodationServiceResponseModel(
        id: json["id"],
        accommodationId: json["accommodation_id"],
        serviceId: json["service_id"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "accommodation_id": accommodationId,
        "service_id": serviceId,
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
    };
}
