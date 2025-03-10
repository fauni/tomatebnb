// To parse this JSON data, do
//
//     final accommodationServicecModel = accommodationServicecModelFromJson(jsonString);

import 'dart:convert';

import 'package:tomatebnb/models/service_response_model.dart';

class AccommodationServicecsResponseModel {
  List<AccommodationServicecResponseModel> items = [];
  AccommodationServicecsResponseModel();
  AccommodationServicecsResponseModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationServiceResponse = AccommodationServicecResponseModel.fromJson(item);
        items.add(accommodationServiceResponse);
      } 
    }
  }
}


AccommodationServicecResponseModel accommodationServicecModelFromJson(String str) => AccommodationServicecResponseModel.fromJson(json.decode(str));

String accommodationServicecModelToJson(AccommodationServicecResponseModel data) => json.encode(data.toJson());

class AccommodationServicecResponseModel {
    int? id;
    int? accommodationId;
    int? serviceId;
    String? description;
    bool? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    ServiceResponseModel? service;

    AccommodationServicecResponseModel({
         this.id,
         this.accommodationId,
         this.serviceId,
         this.description,
         this.status,
         this.createdAt,
         this.updatedAt,
         this.service,
    });

    factory AccommodationServicecResponseModel.fromJson(Map<String, dynamic> json) => AccommodationServicecResponseModel(
        id: json["id"],
        accommodationId: json["accommodation_id"],
        serviceId: json["service_id"],
        description: json["description"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        service: ServiceResponseModel.fromJson(json["service"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "accommodation_id": accommodationId,
        "service_id": serviceId,
        "description": description,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "service": service?.toJson(),
    };
}
