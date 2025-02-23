// To parse this JSON data, do
//
//     final accommodationPriceResponseModel = accommodationPriceResponseModelFromJson(jsonString);

import 'dart:convert';

class AccommodationPricesResponseModel {
  List<AccommodationPriceResponseModel> items = [];
  AccommodationPricesResponseModel();
  AccommodationPricesResponseModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationPriceResponse = AccommodationPriceResponseModel.fromJson(item);
        items.add(accommodationPriceResponse);
      } 
    }
  }
}

// To parse this JSON data, do
//
//     final accommodationPriceResponseModel = accommodationPriceResponseModelFromJson(jsonString);

AccommodationPriceResponseModel accommodationPriceResponseModelFromJson(String str) => AccommodationPriceResponseModel.fromJson(json.decode(str));

String accommodationPriceResponseModelToJson(AccommodationPriceResponseModel data) => json.encode(data.toJson());

class AccommodationPriceResponseModel {
    int accommodationId;
    double priceNight;
    double priceWeekend;
    String type;
    bool status;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    AccommodationPriceResponseModel({
        required this.accommodationId,
        required this.priceNight,
        required this.priceWeekend,
        required this.type,
        required this.status,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory AccommodationPriceResponseModel.fromJson(Map<String, dynamic> json) => AccommodationPriceResponseModel(
        accommodationId: json["accommodation_id"],
        priceNight: double.parse(json["price_night"].toString() ),
        priceWeekend: double.parse(json["price_weekend"].toString()),
        type: json["type"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "accommodation_id": accommodationId,
        "price_night": priceNight,
        "price_weekend": priceWeekend,
        "type": type,
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
