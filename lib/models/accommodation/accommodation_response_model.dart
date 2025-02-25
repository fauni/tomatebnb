// To parse this JSON data, do
//
//     final AccommodationResponseModel = AccommodationResponseModelFromJson(jsonString);
import 'dart:convert';
import 'package:tomatebnb/models/accommodation/accommodation_request_model.dart';

class AccommodationsResponseModel {
  List<AccommodationResponseModel> items = [];
  AccommodationsResponseModel();
  AccommodationsResponseModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationResponse = AccommodationResponseModel.fromJson(item);
        items.add(accommodationResponse);
      } 
    }
  }
}

AccommodationResponseModel accommodationResponseModelFromJson(String str) => AccommodationResponseModel.fromJson(json.decode(str));

String accommodationResponseModelToJson(AccommodationResponseModel data) => json.encode(data.toJson());

class AccommodationResponseModel {
    int? id;
    int? hostId;
    String? title;
    String? description;
    int? typeId;
    int? describeId;
    String? address;
    String? city;
    String? postalCode;
    String? country;
    double? latitude;
    double? longitude;
    int? guestCapacity;
    int? numberRooms;
    int? numberBathrooms;
    int? numberBeds;
    double? priceNight;
    bool? status;
    DateTime? updatedAt;
    DateTime? createdAt;

    AccommodationResponseModel({
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
        this.updatedAt,
        this.createdAt,
    });

     AccommodationResponseModel copyWith({
        int? id,
        int? hostId,
        String? title,
        String? description,
        int? typeId,
        int? describeId,
        String? address,
        String? city,
        String? postalCode,
        String? country,
        double? latitude,
        double? longitude,
        int? guestCapacity,
        int? numberRooms,
        int? numberBathrooms,
        int? numberBeds,
        double? priceNight,
        bool? status,
        DateTime? updatedAt,
        DateTime? createdAt
    }) => 
        AccommodationResponseModel(
            id: id?? this.id,
            hostId: hostId?? this.hostId,
            title: title?? this.title,
            description: description?? this.description,
            typeId: typeId?? this.typeId,
            describeId: describeId?? this.describeId,
            address: address?? this.address,
            city: city?? this.city,
            postalCode: postalCode?? this.postalCode,
            country: country?? this.country,
            latitude: latitude?? this.latitude,
            longitude: longitude?? this.longitude,
            guestCapacity: guestCapacity?? this.guestCapacity,
            numberRooms: numberRooms?? this.numberRooms,
            numberBathrooms: numberBathrooms?? this.numberBathrooms,
            numberBeds: numberBeds?? this.numberBeds,
            priceNight: priceNight?? this.priceNight,
            status: status?? this.status,
            updatedAt: updatedAt?? this.updatedAt,
            createdAt: createdAt?? this.createdAt
        );

    factory AccommodationResponseModel.fromJson(Map<String, dynamic> json) => AccommodationResponseModel(
        id: json["id"] ,
        hostId: json["host_id"],
        title: json["title"],
        description: json["description"],
        typeId: json["type_id"],
        describeId: json["describe_id"],
        address: json["address"],
        city: json["city"],
        postalCode: json["postal_code"],
        country: json["country"],
        latitude: double.tryParse(json["latitude"]??'0.0' ),
        longitude: double.tryParse(json["longitude"]??'0.0'),
        guestCapacity: json["guest_capacity"],
        numberRooms: json["number_rooms"],
        numberBathrooms: json["number_bathrooms"],
        numberBeds: json["number_beds"],
        priceNight: double.tryParse(json["price_night"]??'0.0'),
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
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
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
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
