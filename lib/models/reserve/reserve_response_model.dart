// To parse this JSON data, do
//
//     final reserveResponseModel = reserveResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:tomatebnb/models/accommodation/accommodation_response_model.dart';

class ReservesResponseModel {
  List<ReserveResponseModel> items = [];
  ReservesResponseModel();
  ReservesResponseModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationServiceResponse = ReserveResponseModel.fromJson(item);
        items.add(accommodationServiceResponse);
      } 
    }
  }
}

ReserveResponseModel reserveResponseModelFromJson(String str) => ReserveResponseModel.fromJson(json.decode(str));

String reserveResponseModelToJson(ReserveResponseModel data) => json.encode(data.toJson());

class ReserveResponseModel {
    int? id;
    int? userId;
    int? accommodationId;
    DateTime? startDate;
    DateTime? endDate;
    int? numberGuests;
    double? totalPrice;
    double? cashDiscount;
    double? commission;
    String? state;
    bool? status;
    AccommodationResponseModel? accommodation;

    ReserveResponseModel({
        this.id,
        this.userId,
        this.accommodationId,
        this.startDate,
        this.endDate,
        this.numberGuests,
        this.totalPrice,
        this.cashDiscount,
        this.commission,
        this.state,
        this.status,
        this.accommodation
    });

    factory ReserveResponseModel.fromJson(Map<String, dynamic> json) => ReserveResponseModel(
        id: json["id"],
        userId: json["user_id"],
        accommodationId: int.parse(json["accommodation_id"].toString()) ,
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        numberGuests: json["number_guests"],
        totalPrice: double.parse((json["total_price"]??0).toString()),
        cashDiscount: double.parse((json["cash_discount"]??0).toString()),
        commission: double.parse((json["commission"]??0).toString()),
        state: json["state"],
        status: json["status"],
        accommodation: AccommodationResponseModel.fromJson(json["accommodation"])
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "accommodation_id": accommodationId,
        "start_date": "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate?.year.toString().padLeft(4, '0')}-${endDate?.month.toString().padLeft(2, '0')}-${endDate?.day.toString().padLeft(2, '0')}",
        "number_guests": numberGuests,
        "total_price": totalPrice,
        "cash_discount": cashDiscount,
        "commission": commission,
        "state": state,
        "status": status,
        "accommodation": accommodation?.toJson(),
    };
}
