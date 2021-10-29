
class PostModel {
  String? name;

  String? uId;
  String? image;
  String? coverimage;
  String? datetime;
  String? text;
  String? postimage;

  PostModel({
    this.coverimage,
    this.image,
    this.name,
    this.uId,
    this.datetime,
    this.text,
    this.postimage,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    datetime = json['datetime'];
    postimage = json['postimage'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'datetime': datetime,
      'text': text,
      'postimage': postimage,
    };
  }
}
