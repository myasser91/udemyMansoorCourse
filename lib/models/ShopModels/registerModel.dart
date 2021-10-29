// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
    RegisterModel({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    Data? data;

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.name,
        this.email,
        this.phone,
        this.id,
        this.image,
        this.token,
    });

    String? name;
    String?email;
    String? phone;
    int? id;
    String? image;
    String ? token;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        id: json["id"],
        image: json["image"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "id": id,
        "image": image,
        "token": token,
    };
}
