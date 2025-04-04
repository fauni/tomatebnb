import 'dart:convert';

Describe describeFromJson(String str) => Describe.fromJson(json.decode(str));

String describeToJson(Describe data) => json.encode(data.toJson());

class Describe {
    final int? id;
    final String? describe;
    final bool? status;
    final String? icon;

    Describe({
        this.id,
        this.describe,
        this.status,
        this.icon,
    });

    Describe copyWith({
        int? id,
        String? describe,
        bool? status,
        String? icon,
    }) => 
        Describe(
            id: id ?? this.id,
            describe: describe ?? this.describe,
            status: status ?? this.status,
            icon: icon ?? this.icon,
        );

    factory Describe.fromJson(Map<String, dynamic> json) => Describe(
        id: json["id"],
        describe: json["describe"],
        status: json["status"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "describe": describe,
        "status": status,
        "icon": icon,
    };
}
