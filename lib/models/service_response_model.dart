// To parse this JSON data, do
//
//     final serviceResponseModel = serviceResponseModelFromJson(jsonString);

import 'dart:convert';

class ServicesResponseModel {
  List<ServiceResponseModel> items = [];
  ServicesResponseModel();
  ServicesResponseModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final serviceResponse = ServiceResponseModel.fromJson(item);
        items.add(serviceResponse);
      } 
    }
  }
}


ServiceResponseModel serviceResponseModelFromJson(String str) => ServiceResponseModel.fromJson(json.decode(str));

String serviceResponseModelToJson(ServiceResponseModel data) => json.encode(data.toJson());

class ServiceResponseModel {
    int id;
    String name;
    String description;
    int typeId;
    bool status;
    DateTime createdAt;
    DateTime updatedAt;
    String icon;

    ServiceResponseModel({
        required this.id,
        required this.name,
        required this.description,
        required this.typeId,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.icon,
    });

    factory ServiceResponseModel.fromJson(Map<String, dynamic> json) => ServiceResponseModel(
        id: json["id"],
        name: json["name"],
        description: json["description"]??"",
        typeId: json["type_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        icon: json["icon"]??"",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "type_id": typeId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "icon": icon,
    };
}
