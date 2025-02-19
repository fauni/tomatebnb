// To parse this JSON data, do
//
//     final accommodationServiceRequestModel = accommodationServiceRequestModelFromJson(jsonString);

import 'dart:convert';

class AccommodationServicesRequestModel {
  List<AccommodationServiceRequestModel> items = [];
  AccommodationServicesRequestModel();
  AccommodationServicesRequestModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationServiceRequest = AccommodationServiceRequestModel.fromJson(item);
        items.add(accommodationServiceRequest);
      } 
    }
  }
}


AccommodationServiceRequestModel accommodationServiceRequestModelFromJson(String str) => AccommodationServiceRequestModel.fromJson(json.decode(str));

String accommodationServiceRequestModelToJson(AccommodationServiceRequestModel data) => json.encode(data.toJson());

class AccommodationServiceRequestModel {
    int accommodationId;
    int serviceId;
    String description;
    bool status;
    DateTime updatedAt;
    DateTime createdAt;

    AccommodationServiceRequestModel({
        required this.accommodationId,
        required this.serviceId,
        required this.description,
        required this.status,
        required this.updatedAt,
        required this.createdAt,
    });

    factory AccommodationServiceRequestModel.fromJson(Map<String, dynamic> json) => AccommodationServiceRequestModel(
        accommodationId: json["accommodation_id"],
        serviceId: json["service_id"],
        description: json["description"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "accommodation_id": accommodationId,
        "service_id": serviceId,
        "description": description,
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
    };
}
