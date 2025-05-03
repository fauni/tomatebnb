import 'dart:convert';

AccommodationFilterRequest searchDataFromJson(String str) => AccommodationFilterRequest.fromJson(json.decode(str));

String searchDataToJson(AccommodationFilterRequest data) => json.encode(data.toJson());

class AccommodationFilterRequest {
    int? typeId;
    int? priceRange1;
    int? priceRange2;
    List<int>? services;
    int? rooms;
    int? beds;
    int? bathrooms;

    AccommodationFilterRequest({
        this.typeId,
        this.priceRange1,
        this.priceRange2,
        this.services,
        this.rooms,
        this.beds,
        this.bathrooms,
    });

    AccommodationFilterRequest copyWith({
        int? typeId,
        int? priceRange1,
        int? priceRange2,
        List<int>? services,
        int? rooms,
        int? beds,
        int? bathrooms,
    }) => 
        AccommodationFilterRequest(
            typeId: typeId ?? this.typeId,
            priceRange1: priceRange1 ?? this.priceRange1,
            priceRange2: priceRange2 ?? this.priceRange2,
            services: services ?? this.services,
            rooms: rooms ?? this.rooms,
            beds: beds ?? this.beds,
            bathrooms: bathrooms ?? this.bathrooms,
        );

    factory AccommodationFilterRequest.fromJson(Map<String, dynamic> json) => AccommodationFilterRequest(
        typeId: json["type_id"],
        priceRange1: json["price_range1"],
        priceRange2: json["price_range2"],
        services: json["services"] == null ? [] : List<int>.from(json["services"]!.map((x) => x)),
        rooms: json["rooms"],
        beds: json["beds"],
        bathrooms: json["bathrooms"],
    );

    Map<String, dynamic> toJson() => {
        "type_id": typeId,
        "price_range1": priceRange1,
        "price_range2": priceRange2,
        "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
        "rooms": rooms,
        "beds": beds,
        "bathrooms": bathrooms,
    };
}
