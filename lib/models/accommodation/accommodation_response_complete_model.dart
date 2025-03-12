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

    factory AccommodationResponseCompleteModel.fromJson(Map<String, dynamic> json) {
    return AccommodationResponseCompleteModel(
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
      latitude: double.tryParse(json["latitude"]?.toString() ?? "0.0"),
      longitude: double.tryParse(json["longitude"]?.toString() ?? "0.0"),
      guestCapacity: json["guest_capacity"],
      numberRooms: json["number_rooms"],
      numberBathrooms: json["number_bathrooms"],
      numberBeds: json["number_beds"],
      priceNight: double.tryParse(json["price_night"]?.toString() ?? "0.0"),
      status: json["status"] == true || json["status"] == "true",
      createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) : null,
      updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) : null,
      type: json["type"] != null ? AccommodationTypeResponseModel.fromJson(json["type"]) : null,
      describe: json["describe"] != null ? DescribeResponseModel.fromJson(json["describe"]) : null,
      aspects: (json["aspects"] as List<dynamic>?)
          ?.map((x) => AccommodationAspectResponseModel.fromJson(x))
          .toList() ?? [],
      services: (json["services"] as List<dynamic>?)
          ?.map((x) => AccommodationServiceResponseModel.fromJson(x))
          .toList() ?? [],
      prices: (json["prices"] as List<dynamic>?)
          ?.map((x) => AccommodationPriceResponseModel.fromJson(x))
          .toList() ?? [],
      photos: (json["photos"] as List<dynamic>?)
          ?.map((x) => AccommodationPhotoResponseModel.fromJson(x))
          .toList() ?? [],
      discounts: (json["discounts"] as List<dynamic>?)
          ?.map((x) => AccommodationDiscountResponseModel.fromJson(x))
          .toList() ?? [],
    );
  }

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
        "aspects": aspects?.map((x) => x.toJson()).toList() ?? [],
        "services": services?.map((x) => x.toJson()).toList() ?? [],
        "prices": prices?.map((x) => x.toJson()).toList() ?? [],
        "photos": photos?.map((x) => x.toJson()).toList() ?? [],
        "discounts": discounts?.map((x) => x.toJson()).toList() ?? [],
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