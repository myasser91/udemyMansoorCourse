
class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? coverimage;
  bool? isEmailVerified = false;
  String? bio;
  SocialUserModel(
      {this.coverimage,
      this.bio,
      this.image,
      this.email,
      this.name,
      this.phone,
      this.uId,
      this.isEmailVerified});

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    isEmailVerified = json['isEmailVerified'];
    bio = json['bio'];
    coverimage = json['coverimage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'coverimage': coverimage,
      'image': image,
      'email': email,
      'phone': phone,
      'isEmailVerified': isEmailVerified,
      'bio': bio,
    };
  }
}
