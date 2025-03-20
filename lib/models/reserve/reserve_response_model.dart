// To parse this JSON data, do
//
//     final reserveResponseModel = reserveResponseModelFromJson(jsonString);

import 'dart:convert';

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
    int id;
    int userId;
    int accommodationId;
    DateTime startDate;
    DateTime endDate;
    int numberGuests;
    double totalPrice;
    int cashDiscount;
    int commission;
    String state;
    bool status;

    ReserveResponseModel({
        required this.id,
        required this.userId,
        required this.accommodationId,
        required this.startDate,
        required this.endDate,
        required this.numberGuests,
        required this.totalPrice,
        required this.cashDiscount,
        required this.commission,
        required this.state,
        required this.status,
    });

    factory ReserveResponseModel.fromJson(Map<String, dynamic> json) => ReserveResponseModel(
        id: json["id"],
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
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "accommodation_id": accommodationId,
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "number_guests": numberGuests,
        "total_price": totalPrice,
        "cash_discount": cashDiscount,
        "commission": commission,
        "state": state,
        "status": status,
    };
}
