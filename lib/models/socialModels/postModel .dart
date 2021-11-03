import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/models/socialModels/commentModel.dart';

class PostModel {
  String? name;
Timestamp? time;
  String? uId;
  String? image;
  String? coverimage;
  String? datetime;
  String? text;
  String? postimage;
  String? postavatarimage;
  List<String>? likes;
  List<CommentModel>? comments;


  PostModel({
    this.likes,
    this.coverimage,
    this.image,
    this.name,
    this.uId,
    this.datetime,
    this.text,
    this.postimage,
    this.postavatarimage,
    this.time,
    
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    datetime = json['datetime'];
    postimage = json['postimage'];
    text = json['text'];
    postavatarimage = json['postavatarimage'];
    time =json['time'];
     }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'datetime': datetime,
      'text': text,
      'postimage': postimage,
      'postavatarimage': postavatarimage,
      'time' : Timestamp.now(),
    };
  }
}

class LikesModel {
  String? uId;
  bool? like;
  LikesModel({
    this.uId,
    this.like,
  });

  LikesModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    like = json['like'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'like': like,
    };
  }
}
