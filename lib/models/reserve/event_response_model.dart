// To parse this JSON data, do
//
//     final eventResponseModel = eventResponseModelFromJson(jsonString);

import 'dart:convert';

class EventsResponseModel {
  List<EventResponseModel> items = [];
  EventsResponseModel();
  EventsResponseModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationServiceResponse = EventResponseModel.fromJson(item);
        items.add(accommodationServiceResponse);
      } 
    }
  }
}

EventResponseModel eventResponseModelFromJson(String str) => EventResponseModel.fromJson(json.decode(str));

String eventResponseModelToJson(EventResponseModel data) => json.encode(data.toJson());

class EventResponseModel {
    int? id;
    int? reserveId;
    String? type;
    DateTime? eventDate;
    String? note;
    String? photoUrl;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    EventResponseModel({
         this.id,
         this.reserveId,
         this.type,
         this.eventDate,
         this.note,
         this.photoUrl,
         this.status,
         this.createdAt,
         this.updatedAt,
    });

    factory EventResponseModel.fromJson(Map<String, dynamic> json) => EventResponseModel(
        id: json["id"],
        reserveId: json["reserve_id"],
        type: json["type"],
        eventDate: DateTime.parse(json["event_date"]??"0000-00-00 00:00:00"),
        note: json["note"],
        photoUrl: json["photo_url"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "reserve_id": reserveId,
        "type": type,
        "event_date": eventDate?.toIso8601String(),
        "note": note,
        "photo_url": photoUrl,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
