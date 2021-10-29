// To parse this JSON data, do
//
//     final CategoriesModel = CategoriesModelFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'package:meta/meta.dart';
import 'dart:convert';

CategoriesModel CategoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

String CategoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
    CategoriesModel({
        @required this.status,
        @required this.message,
        @required this.data,
    });

    bool? status;
    dynamic message;
    CategoriesDataModel? data;

    factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"],
        data: json["data"] == null ? null : CategoriesDataModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message,
        "data": data == null ? null : data!.toJson(),
    };
}

class CategoriesDataModel {
    CategoriesDataModel({
        @required this.currentPage,
        @required this.data,
        @required this.firstPageUrl,
        @required this.from,
        @required this.lastPage,
        @required this.lastPageUrl,
        @required this.nextPageUrl,
        @required this.path,
        @required this.perPage,
        @required this.prevPageUrl,
        @required this.to,
        @required this.total,
    });

    int? currentPage;
    List<DataModel>? data;
    String ?firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    dynamic nextPageUrl;
    String ?path;
    int? perPage;
    dynamic prevPageUrl;
    int? to;
    int? total;

    factory CategoriesDataModel.fromJson(Map<String, dynamic> json) => CategoriesDataModel(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null ? null : List<DataModel>.from(json["data"].map((x) => DataModel.fromJson(x))),
        firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl: json["last_page_url"] == null ? null : json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
    };
}

class DataModel {
    DataModel({
        @required this.id,
        @required this.name,
        @required this.image,
    });

    int? id;
    String ?name;
    String ?image;

    factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "image": image == null ? null : image,
    };
}
