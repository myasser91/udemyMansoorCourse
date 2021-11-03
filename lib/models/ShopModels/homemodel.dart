

class HomeModel {
  bool? status;
  HomeDaTaModel? data;
  HomeModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDaTaModel.fromjson(json['data']);
  }
}
class HomeDaTaModel {
  List<BannerModel> banners = [];
  List<ProductsModel> products = [];
  HomeDaTaModel.fromjson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
     banners.add(BannerModel.fromjson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductsModel.fromjson(element));
    });
  }
}
class BannerModel {
  int? id;
  String? image;
  BannerModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCcart;
  ProductsModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCcart = json['in_cart'];
  }
}
