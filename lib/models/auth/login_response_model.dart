// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  final int? id;
  final String? token;
  final String? name;
  final String? email;
  final String? tokenType;
  final String? profilePhoto;
  final String? profilePhotoUrl;

  LoginResponseModel({
    this.id,
    this.token,
    this.name,
    this.email,
    this.tokenType,
    this.profilePhoto,
    this.profilePhotoUrl,
  });

  LoginResponseModel copyWith({
    int? id,
    String? token,
    String? name,
    String? email,
    String? tokenType,
    String? profilePhoto,
    String? profilePhotoUrl,
  }) => 
      LoginResponseModel(
        id: id ?? this.id,
        token: token ?? this.token,
        name: name ?? this.name,
        email: email ?? this.email,
        tokenType: tokenType ?? this.tokenType,
        profilePhoto: profilePhoto ?? this.profilePhoto,
        profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      );

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    id: json["id"],
    token: json["token"],
    name: json["name"],
    email: json["email"],
    tokenType: json["tokenType"],
    profilePhoto:json["profile_photo"],
    profilePhotoUrl: json["profile_photo_url"],
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "token": token,
    "name": name,
    "email": email,
    "tokenType": tokenType,
    "profile_photo":profilePhoto,
    "profile_photo_url": profilePhotoUrl,
  };
}
