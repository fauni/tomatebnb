// To parse this JSON data, do
//
//     final accommodationInstructionResponseModel = accommodationInstructionResponseModelFromJson(jsonString);

import 'dart:convert';

class AccommodationInstructionsResponseModel {
  List<AccommodationInstructionResponseModel> items = [];
  AccommodationInstructionsResponseModel();
  AccommodationInstructionsResponseModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationResponse = AccommodationInstructionResponseModel.fromJson(item);
        items.add(accommodationResponse);
      } 
    }
  }
}

AccommodationInstructionResponseModel accommodationInstructionResponseModelFromJson(String str) => AccommodationInstructionResponseModel.fromJson(json.decode(str));

String accommodationInstructionResponseModelToJson(AccommodationInstructionResponseModel data) => json.encode(data.toJson());

class AccommodationInstructionResponseModel {
    int? id;
    int? accommodationId;
    String? title;
    String? description;
    String? type;
    bool? status;
  
    AccommodationInstructionResponseModel({
        this.id,
        this.accommodationId,
        this.title,
        this.description,
        this.type,
        this.status,
       
    });

    factory AccommodationInstructionResponseModel.fromJson(Map<String, dynamic> json) => AccommodationInstructionResponseModel(
        id: json["id"],
        accommodationId: json["accommodation_id"],
        title: json["title"],
        description: json["description"],
        type: json["type"],
        status: json["status"],

    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "accommodation_id": accommodationId,
        "title": title,
        "description": description,
        "type": type,
        "status": status,

    };
}
