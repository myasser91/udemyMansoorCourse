// // To parse this JSON data, do
// //
// //     final welcome = welcomeFromMap(jsonString);

// import 'dart:convert';

// HomeModel welcomeFromMap(String str) => HomeModel.fromMap(json.decode(str));

// String welcomeToMap(HomeModel data) => json.encode(data.toMap());

// class HomeModel {
//   HomeModel({
//     required this.status,
   
//     required this.data,
//   });

//   bool status;
//   dynamic message;
//   HomeDataModel data;

//   factory HomeModel.fromMap(Map<String, dynamic> json) => HomeModel(
//         status: json["status"],
        
//         data: HomeDataModel.fromMap(json["data"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "status": status,
        
//         "data": data.toMap(),
//       };
// }

// class HomeDataModel {
//   HomeDataModel({
//     required this.banners,
//     required this.products,
//     required this.ad,
//   });

//   List<Banner> banners;
//   List<Product> products;
//   String ad;

//   factory HomeDataModel.fromMap(Map<String, dynamic> json) => HomeDataModel(
//         banners:
//             List<Banner>.from(json["banners"].map((x) => Banner.fromMap(x))),
//         products:
//             List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
//         ad: json["ad"],
//       );

//   Map<String, dynamic> toMap() => {
//         "banners": List<dynamic>.from(banners.map((x) => x.toMap())),
//         "products": List<dynamic>.from(products.map((x) => x.toMap())),
//         "ad": ad,
//       };
// }

// class Banner {
//   Banner({
//     required this.id,
//     required this.image,
//     this.category,
//     this.product,
//   });

//   int id;
//   String image;
//   dynamic category;
//   dynamic product;

//   factory Banner.fromMap(Map<String, dynamic> json) => Banner(
//         id: json["id"],
//         image: json["image"],
//         category: json["category"],
//         product: json["product"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "image": image,
//         "category": category,
//         "product": product,
//       };
// }

// class Product {
//   Product({
//     required this.id,
//     required this.price,
//     required this.oldPrice,
//     required this.discount,
//     required this.image,
//     required this.name,
//     required this.description,
//     required this.images,
//     required this.inFavorites,
//     required this.inCart,
//   });

//   int id;
//   double price;
//   double oldPrice;
//   int discount;
//   String image;
//   String name;
//   String description;
//   List<String> images;
//   bool inFavorites;
//   bool inCart;

//   factory Product.fromMap(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         price: json["price"].toDouble(),
//         oldPrice: json["old_price"].toDouble(),
//         discount: json["discount"],
//         image: json["image"],
//         name: json["name"],
//         description: json["description"],
//         images: List<String>.from(json["images"].map((x) => x)),
//         inFavorites: json["in_favorites"],
//         inCart: json["in_cart"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "price": price,
//         "old_price": oldPrice,
//         "discount": discount,
//         "image": image,
//         "name": name,
//         "description": description,
//         "images": List<dynamic>.from(images.map((x) => x)),
//         "in_favorites": inFavorites,
//         "in_cart": inCart,
//       };
// }
