// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    final String? token;
    final String? name;
    final String? email;
    final String? tokenType;

    LoginResponse({
        this.token,
        this.name,
        this.email,
        this.tokenType,
    });

    LoginResponse copyWith({
        String? token,
        String? name,
        String? email,
        String? tokenType,
    }) => 
        LoginResponse(
            token: token ?? this.token,
            name: name ?? this.name,
            email: email ?? this.email,
            tokenType: tokenType ?? this.tokenType,
        );

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
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
