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
    int? id;
    String? name;
    String? description;
    bool? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    AccommodationTypeResponseModel({
         this.id,
         this.name,
         this.description,
         this.status,
         this.createdAt,
         this.updatedAt,
    });

    factory AccommodationTypeResponseModel.fromJson(Map<String, dynamic> json) => AccommodationTypeResponseModel(
        id: json["id"]??0,
        name: json["name"]??'',
        description: json["description"]??'',
        status: json["status"]??false,
        createdAt: DateTime.parse(json["created_at"]??'2000-01-01'),
        updatedAt: DateTime.parse(json["updated_at"]??'2000-01-01'),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
