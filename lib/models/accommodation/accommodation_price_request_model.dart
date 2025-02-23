// To parse this JSON data, do
//
//     final accommodationPriceRequestModel = accommodationPriceRequestModelFromJson(jsonString);

import 'dart:convert';

class AccommodationPricesRequestModel {
  List<AccommodationPriceRequestModel> items = [];
  AccommodationPricesRequestModel();
  AccommodationPricesRequestModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationPriceRequest = AccommodationPriceRequestModel.fromJson(item);
        items.add(accommodationPriceRequest);
      } 
    }
  }
}
// To parse this JSON data, do
//
//     final accommodationPriceRequestModel = accommodationPriceRequestModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final accommodationPriceRequestModel = accommodationPriceRequestModelFromJson(jsonString);



AccommodationPriceRequestModel accommodationPriceRequestModelFromJson(String str) => AccommodationPriceRequestModel.fromJson(json.decode(str));

String accommodationPriceRequestModelToJson(AccommodationPriceRequestModel data) => json.encode(data.toJson());

class AccommodationPriceRequestModel {
    int? accommodationId;
    double? priceNight;
    double? priceWeekend;
    String? type;
    bool? status;

    AccommodationPriceRequestModel({
         this.accommodationId,
         this.priceNight,
         this.priceWeekend,
         this.type,
         this.status,
    });

    factory AccommodationPriceRequestModel.fromJson(Map<String, dynamic> json) => AccommodationPriceRequestModel(
        accommodationId: json["accommodation_id"],
        priceNight: json["price_night"]?.toDouble(),
        priceWeekend: json["price_weekend"]?.toDouble(),
        type: json["type"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "accommodation_id": accommodationId,
        "price_night": priceNight,
        "price_weekend": priceWeekend,
        "type": type,
        "status": status,
    };
}
