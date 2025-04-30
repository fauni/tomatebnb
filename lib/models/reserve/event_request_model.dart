// To parse this JSON data, do
//
//     final eventRequestModel = eventRequestModelFromJson(jsonString);

import 'dart:convert';

class EventsRequestModel {
  List<EventRequestModel> items = [];
  EventsRequestModel();
  EventsRequestModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationServiceRequest = EventRequestModel.fromJson(item);
        items.add(accommodationServiceRequest);
      } 
    }
  }
}

EventRequestModel eventRequestModelFromJson(String str) => EventRequestModel.fromJson(json.decode(str));

String eventRequestModelToJson(EventRequestModel data) => json.encode(data.toJson());

class EventRequestModel {
    int? id;
    int? reserveId;
    String? type;
    DateTime? eventDate;
    String? note;
    String? photoUrl;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    EventRequestModel({
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

    factory EventRequestModel.fromJson(Map<String, dynamic> json) => EventRequestModel(
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
