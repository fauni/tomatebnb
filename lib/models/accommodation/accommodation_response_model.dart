// To parse this JSON data, do
//
//     final AccommodationResponseModel = AccommodationResponseModelFromJson(jsonString);
import 'dart:convert';
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
    int? priceNight;
    bool? status;
    DateTime? updatedAt;
    DateTime? createdAt;

    AccommodationResponseModel({
        required this.id,
        required this.hostId,
        required this.title,
        required this.description,
        required this.typeId,
        required this.describeId,
        required this.address,
        required this.city,
        required this.postalCode,
        required this.country,
        required this.latitude,
        required this.longitude,
        required this.guestCapacity,
        required this.numberRooms,
        required this.numberBathrooms,
        required this.numberBeds,
        required this.priceNight,
        required this.status,
        required this.updatedAt,
        required this.createdAt,
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
        int? priceNight,
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
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        guestCapacity: json["guest_capacity"],
        numberRooms: json["number_rooms"],
        numberBathrooms: json["number_bathrooms"],
        numberBeds: json["number_beds"],
        priceNight: json["price_night"],
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
}
