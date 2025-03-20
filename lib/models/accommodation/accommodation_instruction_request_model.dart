// To parse this JSON data, do
//
//     final accommodationInstructionRequestModel = accommodationInstructionRequestModelFromJson(jsonString);

import 'dart:convert';

class AccommodationInstructionsRequestModel {
  List<AccommodationInstructionRequestModel> items = [];
  AccommodationInstructionsRequestModel();
  AccommodationInstructionsRequestModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationRequest = AccommodationInstructionRequestModel.fromJson(item);
        items.add(accommodationRequest);
      } 
    }
  }
}

AccommodationInstructionRequestModel accommodationInstructionRequestModelFromJson(String str) => AccommodationInstructionRequestModel.fromJson(json.decode(str));

String accommodationInstructionRequestModelToJson(AccommodationInstructionRequestModel data) => json.encode(data.toJson());

class AccommodationInstructionRequestModel {
    int? accommodationId;
    String? title;
    String? description;
    String? type;
    bool? status;
  
    AccommodationInstructionRequestModel({
        this.accommodationId,
        this.title,
        this.description,
        this.type,
        this.status,
       
    });

    factory AccommodationInstructionRequestModel.fromJson(Map<String, dynamic> json) => AccommodationInstructionRequestModel(
        accommodationId: json["accommodation_id"],
        title: json["title"],
        description: json["description"],
        type: json["type"],
        status: json["status"],

    );

    Map<String, dynamic> toJson() => {
        "accommodation_id": accommodationId,
        "title": title,
        "description": description,
        "type": type,
        "status": status,

    };
}
