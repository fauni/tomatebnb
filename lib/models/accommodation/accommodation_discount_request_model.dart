// To parse this JSON data, do
//
//     final accommodationDiscountRequestModel = accommodationDiscountRequestModelFromJson(jsonString);

import 'dart:convert';

class AccommodationDiscountsRequestModel {
  List<AccommodationDiscountRequestModel> items = [];
  AccommodationDiscountsRequestModel();
  AccommodationDiscountsRequestModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationDiscountRequest = AccommodationDiscountRequestModel.fromJson(item);
        items.add(accommodationDiscountRequest);
      } 
    }
  }
}
// To parse this JSON data, do
//
//     final accommodationDiscountRequestModel = accommodationDiscountRequestModelFromJson(jsonString);


AccommodationDiscountRequestModel accommodationDiscountRequestModelFromJson(String str) => AccommodationDiscountRequestModel.fromJson(json.decode(str));

String accommodationDiscountRequestModelToJson(AccommodationDiscountRequestModel data) => json.encode(data.toJson());

class AccommodationDiscountRequestModel {
    int? accommodationId;
    double? discountValuea;
    double? discountValueb;
    double? discountValuec;
    double? discountValued;
    bool? status;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    AccommodationDiscountRequestModel({
         this.accommodationId,
         this.discountValuea,
         this.discountValueb,
         this.discountValuec,
         this.discountValued,
         this.status,
         this.updatedAt,
         this.createdAt,
         this.id,
    });

    factory AccommodationDiscountRequestModel.fromJson(Map<String, dynamic> json) => AccommodationDiscountRequestModel(
        accommodationId: json["accommodation_id"],
        discountValuea: json["discount_valuea"]?.toDouble(),
        discountValueb: json["discount_valueb"]?.toDouble(),
        discountValuec: json["discount_valuec"]?.toDouble(),
        discountValued: json["discount_valued"]?.toDouble(),
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "accommodation_id": accommodationId,
        "discount_valuea": discountValuea,
        "discount_valueb": discountValueb,
        "discount_valuec": discountValuec,
        "discount_valued": discountValued,
        "status": status,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
