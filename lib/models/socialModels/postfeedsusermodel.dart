class PostfeedUserData {
  String? name;
  String? image;

  PostfeedUserData({this.image, this.name});

  PostfeedUserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
    };
  }
}
