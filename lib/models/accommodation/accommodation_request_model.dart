// To parse this JSON data, do
//
//     final AccommodationRequestModel = AccommodationRequestModelFromJson(jsonString);

import 'dart:convert';

AccommodationRequestModel accommodationRequestModelFromJson(String str) => AccommodationRequestModel.fromJson(json.decode(str));

String accommodationRequestModelToJson(AccommodationRequestModel data) => json.encode(data.toJson());

class AccommodationRequestModel {
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

    AccommodationRequestModel({
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
    });

    AccommodationRequestModel copyWith({
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
    }) => 
        AccommodationRequestModel(
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
        );

    factory AccommodationRequestModel.fromJson(Map<String, dynamic> json) => AccommodationRequestModel(
        hostId: json["host_id"],
        title: json["title"],
        description: json["description"],
        typeId: json["type_id"],
        describeId: json["describe_id"],
        address: json["address"],
        city: json["city"],
        postalCode: json["postal_code"],
        country: json["country"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        guestCapacity: json["guest_capacity"],
        numberRooms: json["number_rooms"],
        numberBathrooms: json["number_bathrooms"],
        numberBeds: json["number_beds"],
        priceNight: double.parse(json["price_night"]??'00.00'),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
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
    };
}
