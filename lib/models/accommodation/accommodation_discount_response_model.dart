// To parse this JSON data, do
//
//     final accommodationDiscountResponseModel = accommodationDiscountResponseModelFromJson(jsonString);

import 'dart:convert';

class AccommodationDiscountsResponseModel {
  List<AccommodationDiscountResponseModel> items = [];
  AccommodationDiscountsResponseModel();
  AccommodationDiscountsResponseModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationDiscountResponse = AccommodationDiscountResponseModel.fromJson(item);
        items.add(accommodationDiscountResponse);
      } 
    }
  }
}


AccommodationDiscountResponseModel accommodationDiscountResponseModelFromJson(String str) => AccommodationDiscountResponseModel.fromJson(json.decode(str));

String accommodationDiscountResponseModelToJson(AccommodationDiscountResponseModel data) => json.encode(data.toJson());

class AccommodationDiscountResponseModel {
    int accommodationId;
    double discountValuea;
    double discountValueb;
    double discountValuec;
    double discountValued;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    AccommodationDiscountResponseModel({
        required this.accommodationId,
        required this.discountValuea,
        required this.discountValueb,
        required this.discountValuec,
        required this.discountValued,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory AccommodationDiscountResponseModel.fromJson(Map<String, dynamic> json) => AccommodationDiscountResponseModel(
        accommodationId: json["accommodation_id"],
        discountValuea: double.parse(json["discount_valuea"].toString()),
        discountValueb: double.parse(json["discount_valueb"].toString()),
        discountValuec: double.parse(json["discount_valuec"].toString()),
        discountValued: double.parse(json["discount_valued"].toString()),
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
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
