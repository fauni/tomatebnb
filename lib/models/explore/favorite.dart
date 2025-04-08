// To parse this JSON data, do
//
//     final favorite = favoriteFromJson(jsonString);

import 'dart:convert';

Favorite favoriteFromJson(String str) => Favorite.fromJson(json.decode(str));

String favoriteToJson(Favorite data) => json.encode(data.toJson());

class Favorite {
    final int? userId;
    final String? accommodationId;
    final DateTime? updatedAt;
    final DateTime? createdAt;
    final int? id;

    Favorite({
        this.userId,
        this.accommodationId,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    Favorite copyWith({
        int? userId,
        String? accommodationId,
        DateTime? updatedAt,
        DateTime? createdAt,
        int? id,
    }) => 
        Favorite(
            userId: userId ?? this.userId,
            accommodationId: accommodationId ?? this.accommodationId,
            updatedAt: updatedAt ?? this.updatedAt,
            createdAt: createdAt ?? this.createdAt,
            id: id ?? this.id,
        );

    factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        userId: json["user_id"],
        accommodationId: json["accommodation_id"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "accommodation_id": accommodationId,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
