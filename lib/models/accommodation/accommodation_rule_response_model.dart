// To parse this JSON data, do
//
//     final accommodationRuleResponseModel = accommodationRuleResponseModelFromJson(jsonString);

import 'dart:convert';

class AccommodationRulesResponseModel {
  List<AccommodationRuleResponseModel> items = [];
  AccommodationRulesResponseModel();
  AccommodationRulesResponseModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationResponse = AccommodationRuleResponseModel.fromJson(item);
        items.add(accommodationResponse);
      } 
    }
  }
}
AccommodationRuleResponseModel accommodationRuleResponseModelFromJson(String str) => AccommodationRuleResponseModel.fromJson(json.decode(str));

String accommodationRuleResponseModelToJson(AccommodationRuleResponseModel data) => json.encode(data.toJson());

class AccommodationRuleResponseModel {
    int accommodationId;
    String title;
    String description;
    int id;

    AccommodationRuleResponseModel({
        required this.accommodationId,
        required this.title,
        required this.description,
        required this.id,
    });

    factory AccommodationRuleResponseModel.fromJson(Map<String, dynamic> json) => AccommodationRuleResponseModel(
        accommodationId: json["accommodation_id"],
        title: json["title"],
        description: json["description"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "accommodation_id": accommodationId,
        "title": title,
        "description": description,
        "id": id,
    };
}
