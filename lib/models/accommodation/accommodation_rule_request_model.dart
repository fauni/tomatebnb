// To parse this JSON data, do
//
//     final accommodationRuleRequestModel = accommodationRuleRequestModelFromJson(jsonString);

import 'dart:convert';

class AccommodationRulesRequestModel {
  List<AccommodationRuleRequestModel> items = [];
  AccommodationRulesRequestModel();
  AccommodationRulesRequestModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationRequest = AccommodationRuleRequestModel.fromJson(item);
        items.add(accommodationRequest);
      } 
    }
  }
}
AccommodationRuleRequestModel accommodationRuleRequestModelFromJson(String str) => AccommodationRuleRequestModel.fromJson(json.decode(str));

String accommodationRuleRequestModelToJson(AccommodationRuleRequestModel data) => json.encode(data.toJson());

class AccommodationRuleRequestModel {
    int? accommodationId;
    String? title;
    String? description;
    

    AccommodationRuleRequestModel({
         this.accommodationId,
         this.title,
         this.description,
        
    });

    factory AccommodationRuleRequestModel.fromJson(Map<String, dynamic> json) => AccommodationRuleRequestModel(
        accommodationId: json["accommodation_id"],
        title: json["title"],
        description: json["description"],
        
    );

    Map<String, dynamic> toJson() => {
        "accommodation_id": accommodationId,
        "title": title,
        "description": description,
        
    };
}
