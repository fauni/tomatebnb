// To parse this JSON data, do
//
//     final describeResponseModel = describeResponseModelFromJson(jsonString);

import 'dart:convert';

class DescribesResponseModel {
  List<DescribeResponseModel> items = [];
  DescribesResponseModel();
  DescribesResponseModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final describeResponse = DescribeResponseModel.fromJson(item);
        items.add(describeResponse);
      } 
    }
  }
}

DescribeResponseModel describeResponseModelFromJson(String str) => DescribeResponseModel.fromJson(json.decode(str));

String describeResponseModelToJson(DescribeResponseModel data) => json.encode(data.toJson());

class DescribeResponseModel {
    int? id;
    String? describe;
    bool? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    DescribeResponseModel({
         this.id,
         this.describe,
         this.status,
         this.createdAt,
         this.updatedAt,
    });

    factory DescribeResponseModel.fromJson(Map<String, dynamic> json) => DescribeResponseModel(
        id: json["id"]??0,
        describe: json["describe"]??'',
        status: json["status"]??false,
        createdAt: DateTime.parse(json["created_at"]??'2000-01-01'),
        updatedAt: DateTime.parse(json["updated_at"]??'2000-01-01'),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "describe": describe,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
