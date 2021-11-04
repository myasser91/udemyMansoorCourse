import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/models/socialModels/commentModel.dart';

class StoryModel {
  String? name;
Timestamp? time;
  String? uId;
  String? image; 
  String? datetime;  
  String? storyimage;
  


  StoryModel({
   
    this.image,
    this.name,
    this.uId,
    this.datetime,   
    this.storyimage,   
    this.time,
    
  });

  StoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    datetime = json['datetime'];
    storyimage = json['storyimage'];    
    time =json['time'];
   
     }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'datetime': datetime,     
      'storyimage': storyimage,      
      'time' : Timestamp.now(),
    };
  }
}


  

