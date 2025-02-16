// To parse this JSON data, do
//
//     final accommodationTypeResponseModel = accommodationTypeResponseModelFromJson(jsonString);

import 'dart:convert';

class AccommodationTypesResponseModel {
  List<AccommodationTypeResponseModel> items = [];
  AccommodationTypesResponseModel();
  AccommodationTypesResponseModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationTypeResponse = AccommodationTypeResponseModel.fromJson(item);
        items.add(accommodationTypeResponse);
      } 
    }
  }
}

AccommodationTypeResponseModel accommodationTypeResponseModelFromJson(String str) => AccommodationTypeResponseModel.fromJson(json.decode(str));
String accommodationTypeResponseModelToJson(AccommodationTypeResponseModel data) => json.encode(data.toJson());

class AccommodationTypeResponseModel {
    int id;
    String name;
    String description;
    bool status;
    DateTime createdAt;
    DateTime updatedAt;

    AccommodationTypeResponseModel({
        required this.id,
        required this.name,
        required this.description,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory AccommodationTypeResponseModel.fromJson(Map<String, dynamic> json) => AccommodationTypeResponseModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
