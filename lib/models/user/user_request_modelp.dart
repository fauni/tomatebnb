// To parse this JSON data, do
//
//     final userRequestModel = userRequestModelFromJson(jsonString);

import 'dart:convert';

class UsersRequestModelp {
  List<UserRequestModelp> items = [];
  UsersRequestModelp();
  UsersRequestModelp.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) {
      return;
    } else {
      for (var item in jsonList) {
        final userRequest = UserRequestModelp.fromJson(item);
        items.add(userRequest);
      } 
    }
  }
}

UserRequestModelp userRequestModelFromJson(String str) => UserRequestModelp.fromJson(json.decode(str));

String userRequestModelToJson(UserRequestModelp data) => json.encode(data.toJson());

class UserRequestModelp {
    
    String? name;
    String? lastname;
    String? email;
    DateTime? emailVerifiedAt;
    String? phone;
    String? biography;
    String? profilePhoto;
    DateTime? recordDate;
    bool? verified;
    String? documentNumber;
    String? documentType;
    String? documentPhotoFront;
    String? documentPhotoBack;
    bool? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? confirmPhoto;
    String? password;
    UserRequestModelp({
        this.name,
        this.lastname,
        this.email,
        this.emailVerifiedAt,
        this.phone,
        this.biography,
        this.profilePhoto,
        this.recordDate,
        this.verified,
        this.documentNumber,
        this.documentType,
        this.documentPhotoFront,
        this.documentPhotoBack,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.confirmPhoto,
        this.password
        
    });

    factory UserRequestModelp.fromJson(Map<String, dynamic> json) => UserRequestModelp(
        
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        phone: json["phone"],
        biography: json["biography"],
        profilePhoto: json["profile_photo"],
        recordDate: DateTime.parse(json["record_date"]),
        verified: json["verified"],
        documentNumber: json["document_number"],
        documentType: json["document_type"],
        documentPhotoFront: json["document_photo_front"],
        documentPhotoBack: json["document_photo_back"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        confirmPhoto: json["confirm_photo"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "phone": phone,
        "biography": biography,
        "profile_photo": profilePhoto,
        "record_date": recordDate?.toIso8601String(),
        "verified": verified,
        "document_number": documentNumber,
        "document_type": documentType,
        "document_photo_front": documentPhotoFront,
        "document_photo_back": documentPhotoBack,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "confirm_photo": confirmPhoto,
        "password":password
       
    };
}
