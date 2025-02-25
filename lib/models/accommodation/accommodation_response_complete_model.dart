// To parse this JSON data, do
//
//     final accommodationResponseCompleteModel = accommodationResponseCompleteModelFromJson(jsonString);

import 'dart:convert';

import 'package:tomatebnb/models/accommodation/accommodation_aspect_response_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_discount_response_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_photo_response_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_price_response_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_service_response_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_type_response_model.dart';
import 'package:tomatebnb/models/accommodation/describe_response_model.dart';

class AccommodationsResponseCompleteModel {
  List<AccommodationResponseCompleteModel> items = [];
  AccommodationsResponseCompleteModel();
  AccommodationsResponseCompleteModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationResponse = AccommodationResponseCompleteModel.fromJson(item);
        items.add(accommodationResponse);
      } 
    }
  }
}
AccommodationResponseCompleteModel accommodationResponseCompleteModelFromJson(String str) => AccommodationResponseCompleteModel.fromJson(json.decode(str));

String accommodationResponseCompleteModelToJson(AccommodationResponseCompleteModel data) => json.encode(data.toJson());

class AccommodationResponseCompleteModel {
    int? id;
    int? hostId;
    String? title;
    String? description;
    int? typeId;
    int? describeId;
    String? address;
    String? city;
    dynamic? postalCode;
    String? country;
    double? latitude;
    double? longitude;
    int? guestCapacity;
    int? numberRooms;
    int? numberBathrooms;
    int? numberBeds;
    double? priceNight;
    bool? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    AccommodationTypeResponseModel? type;
    DescribeResponseModel? describe;
    List<AccommodationAspectResponseModel>? aspects;
    List<AccommodationServiceResponseModel>? services;
    List<AccommodationPriceResponseModel>? prices;
    List<AccommodationPhotoResponseModel>? photos;
    List<AccommodationDiscountResponseModel>? discounts;

    AccommodationResponseCompleteModel({
         this.id,
         this.hostId,
         this.title,
         this.description,
         this.typeId,
         this.describeId,
         this.address,
         this.city,
         this.postalCode,
         this.country,
         this.latitude,
         this.longitude,
         this.guestCapacity,
         this.numberRooms,
         this.numberBathrooms,
         this.numberBeds,
         this.priceNight,
         this.status,
         this.createdAt,
         this.updatedAt,
         this.type,
         this.describe,
         this.aspects,
         this.services,
         this.prices,
         this.photos,
         this.discounts,
    });

    factory AccommodationResponseCompleteModel.fromJson(Map<String, dynamic> json) => AccommodationResponseCompleteModel(
        id: json["id"],
        hostId: json["host_id"],
        title: json["title"],
        description: json["description"],
        typeId: json["type_id"],
        describeId: json["describe_id"],
        address: json["address"],
        city: json["city"],
        postalCode: json["postal_code"],
        country: json["country"],
        latitude: double.parse(json["latitude"]??"0.0"),
        longitude: double.parse(json["longitude"]??"0.0"),
        guestCapacity: json["guest_capacity"],
        numberRooms: json["number_rooms"],
        numberBathrooms: json["number_bathrooms"],
        numberBeds: json["number_beds"],
        priceNight: double.parse(json["price_night"]??'0.0'),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        type: AccommodationTypeResponseModel.fromJson(json["type"]??AccommodationTypeResponseModel().toJson()),
        describe: DescribeResponseModel.fromJson(json["describe"]??DescribeResponseModel().toJson()),
        aspects: List<AccommodationAspectResponseModel>.from(json["aspects"].map((x) => AccommodationAspectResponseModel.fromJson(x))),
        services: List<AccommodationServiceResponseModel>.from(json["services"].map((x) => AccommodationServiceResponseModel.fromJson(x))),
        prices: List<AccommodationPriceResponseModel>.from(json["prices"].map((x) => AccommodationPriceResponseModel.fromJson(x))),
        photos: List<AccommodationPhotoResponseModel>.from(json["photos"].map((x) => AccommodationPhotoResponseModel.fromJson(x))),
        discounts: List<AccommodationDiscountResponseModel>.from(json["discounts"].map((x) => AccommodationDiscountResponseModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "host_id": hostId,
        "title": title,
        "description": description,
        "type_id": typeId,
        "describe_id": describeId,
        "address": address,
        "city": city,
        "postal_code": postalCode,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "guest_capacity": guestCapacity,
        "number_rooms": numberRooms,
        "number_bathrooms": numberBathrooms,
        "number_beds": numberBeds,
        "price_night": priceNight,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "type": type?.toJson(),
        "describe": describe?.toJson(),
        "aspects": aspects == null ? [] : List<dynamic>.from(aspects!.map((x) => x.toJson())),
        "services": services == null ?[]:List<dynamic>.from(services!.map((x) => x.toJson())),
        "prices":prices == null ? []: List<dynamic>.from(prices!.map((x) => x.toJson())),
        "photos":photos == null ? []: List<dynamic>.from(photos!.map((x) => x.toJson())),
        "discounts":discounts== null ? []: List<dynamic>.from(discounts!.map((x) => x.toJson())),
    };
     AccommodationRequestModel toRequestModel() => AccommodationRequestModel(
        hostId: hostId,
        title: title,
        description: description,
        typeId: typeId,
        describeId: describeId,
        address: address,
        city: city,
        postalCode: postalCode,
        country: country,
        latitude: latitude,
        longitude: longitude,
        guestCapacity: guestCapacity,
        numberRooms: numberRooms,
        numberBathrooms: numberBathrooms,
        numberBeds: numberBeds,
        priceNight: priceNight,
        status: status,
    );
}
