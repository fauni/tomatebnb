
// To parse this JSON data, do
//
//     final reserveRequestModel = reserveRequestModelFromJson(jsonString);

import 'dart:convert';

class ReservesRequestModel {
  List<ReserveRequestModel> items = [];
  ReservesRequestModel();
  ReservesRequestModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final accommodationServiceRequest = ReserveRequestModel.fromJson(item);
        items.add(accommodationServiceRequest);
      } 
    }
  }
}

ReserveRequestModel reserveRequestModelFromJson(String str) => ReserveRequestModel.fromJson(json.decode(str));

String reserveRequestModelToJson(ReserveRequestModel data) => json.encode(data.toJson());

class ReserveRequestModel {
    int? userId;
    int? accommodationId;
    DateTime? startDate;
    DateTime? endDate;
    int? numberGuests;
    double? totalPrice;
    int? cashDiscount;
    int? commission;
    String? state;
    bool? status;
    DateTime? checkinDate;
    DateTime? checkoutDate;
    ReserveRequestModel({
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
         this.checkinDate,
         this.checkoutDate,
    });

    factory ReserveRequestModel.fromJson(Map<String, dynamic> json) => ReserveRequestModel(  
        userId: json["user_id"],
        accommodationId: json["accommodation_id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        numberGuests: json["number_guests"],
        totalPrice: json["total_price"]?.toDouble(),
        cashDiscount: json["cash_discount"],
        commission: json["commission"],
        state: json["state"],
        status: json["status"],
        checkinDate: DateTime.parse(json["checkin_date"]?? "2000-01-01 00:00:00"),
        checkoutDate: DateTime.parse(json["checkout_date"]?? "2000-01-01 00:00:00"),
    );

    Map<String, dynamic> toJson() => {
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
        "checkin_date": checkinDate?.toIso8601String(),
        "checkout_date": checkoutDate?.toIso8601String(),
    };
}
