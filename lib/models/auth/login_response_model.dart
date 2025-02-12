// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    final String? token;
    final String? name;
    final String? email;
    final String? tokenType;

    LoginResponseModel({
        this.token,
        this.name,
        this.email,
        this.tokenType,
    });

    LoginResponseModel copyWith({
        String? token,
        String? name,
        String? email,
        String? tokenType,
    }) => 
        LoginResponseModel(
            token: token ?? this.token,
            name: name ?? this.name,
            email: email ?? this.email,
            tokenType: tokenType ?? this.tokenType,
        );

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        token: json["token"],
        name: json["name"],
        email: json["email"],
        tokenType: json["tokenType"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
        "email": email,
        "tokenType": tokenType,
    };
}
