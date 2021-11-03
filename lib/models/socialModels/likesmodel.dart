class LikesModel{
String? name;
String? image;
String? userId;

LikesModel({this.name,this.image});

 LikesModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    userId = json['userId'];
    
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'userId':userId,      
    };
  }

}