// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
    SearchModel({
        @required this.status,
        @required this.message,
        @required this.data,
    });

    bool ?status;
    dynamic message;
    Data? data;

    factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
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
        @required this.currentPage,
        @required this.data,
    
    });

    int ?currentPage;
    List<Products>? data;
   

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Products>.from(json["data"].map((x) => Products.fromJson(x))),
        
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        
    };
}

class Products {
    Products({
        @required this.id,
        @required this.price,
        @required this.oldPrice,
        @required this.discount,
        @required this.image,
        @required this.name,
        @required this.description,
        @required this.images,
        @required this.inFavorites,
        @required this.inCart,
    });

    int ?id;
    dynamic price;
    dynamic oldPrice;
    int ?discount;
    String? image;
    String ?name;
    String? description;
    List<String>? images;
    bool ?inFavorites;
    bool ?inCart;

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        price: json["price"],
        oldPrice: json["old_price"],
        discount: json["discount"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        inFavorites: json["in_favorites"],
        inCart: json["in_cart"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "old_price": oldPrice,
        "discount": discount,
        "image": image,
        "name": name,
        "description": description,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "in_favorites": inFavorites,
        "in_cart": inCart,
    };
}
