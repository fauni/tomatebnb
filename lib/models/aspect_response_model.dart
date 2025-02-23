// To parse this JSON data, do
//
//     final aspectResponseModel = aspectResponseModelFromJson(jsonString);

import 'dart:convert';

class AspectsResponseModel {
  List<AspectResponseModel> items = [];
  AspectsResponseModel();
  AspectsResponseModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final aspectResponse = AspectResponseModel.fromJson(item);
        items.add(aspectResponse);
      } 
    }
  }
}

// To parse this JSON data, do
//
//     final aspectResponseModel = aspectResponseModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final aspectResponseModel = aspectResponseModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final aspectResponseModel = aspectResponseModelFromJson(jsonString);



AspectResponseModel aspectResponseModelFromJson(String str) => AspectResponseModel.fromJson(json.decode(str));

String aspectResponseModelToJson(AspectResponseModel data) => json.encode(data.toJson());

class AspectResponseModel {
    int id;
    String description;
    int describeId;
    bool status;
    DateTime createdAt;
    DateTime updatedAt;

    AspectResponseModel({
        required this.id,
        required this.description,
        required this.describeId,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory AspectResponseModel.fromJson(Map<String, dynamic> json) => AspectResponseModel(
        id: json["id"],
        description: json["description"],
        describeId: json["describe_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "describe_id": describeId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
