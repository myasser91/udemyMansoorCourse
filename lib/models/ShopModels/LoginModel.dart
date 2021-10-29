class ShopLoginModel{

bool? status;
String? message;
UserData? data;

ShopLoginModel.fromJson(Map<String,dynamic> json){

  status = json['status'];
  message = json['message'];
  data = json['data'] !=null ?UserData.fromJson(json['data']):null;
  
}

}

class UserData
{
int? id;
String? name;
String? phone;
String? image;
int? points;
int? credit;
String? token;
String? email;
UserData({
  this.email,this.id,this.image,this.credit,this.name,this.phone,this.points,this.token,
});
UserData.fromJson(Map<String,dynamic> json){

  id = json['id'];
  name = json['name'];
  phone = json['phone'];
  image = json['image'];
  points = json['points'];
  credit = json['credit'];
  token = json['token'];
  email = json['email'];
}


}


