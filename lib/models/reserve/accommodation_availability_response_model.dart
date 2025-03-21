// To parse this JSON data, do
//
//     final accommodationAvailabilityResponseModel = accommodationAvailabilityResponseModelFromJson(jsonString);

import 'dart:convert';

class AccommodationAvailabilitiesResponseModel {
  List<AccommodationAvailabilityResponseModel> items = [];
  AccommodationAvailabilitiesResponseModel();
  AccommodationAvailabilitiesResponseModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationServiceResponse = AccommodationAvailabilityResponseModel.fromJson(item);
        items.add(accommodationServiceResponse);
      } 
    }
  }
}

AccommodationAvailabilityResponseModel accommodationAvailabilityResponseModelFromJson(String str) => AccommodationAvailabilityResponseModel.fromJson(json.decode(str));

String accommodationAvailabilityResponseModelToJson(AccommodationAvailabilityResponseModel data) => json.encode(data.toJson());

class AccommodationAvailabilityResponseModel {
    int? id;
    int? accommodationId;
    DateTime? startDate;
    dynamic? endDate;
    int? availability;
    bool? status;
    int? reserveId;

    AccommodationAvailabilityResponseModel({
         this.id,
         this.accommodationId,
         this.startDate,
         this.endDate,
         this.availability,
         this.status,
         this.reserveId,
    });

    factory AccommodationAvailabilityResponseModel.fromJson(Map<String, dynamic> json) => AccommodationAvailabilityResponseModel(
        id: json["id"],
        accommodationId: json["accommodation_id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: json["end_date"],
        availability: json["availability"],
        status: json["status"],
        reserveId: json["reserve_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "accommodation_id": accommodationId,
        "start_date": "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
        "end_date": endDate,
        "availability": availability,
        "status": status,
        "reserve_id": reserveId,
    };
}
