class CommentModel {
  String? text;
  String? dateTime;
  String? postid;
  String? userId;
  String? userImage;
  String? name;
  String? commentId;
  

  CommentModel({this.text, this.commentId,this.name,this.userImage,this.dateTime,this.userId,this.postid});

  CommentModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    text = json['text'];
    userId = json['userId'];
    userImage = json['userImage'];
    name = json['name'];
    postid = json['postid'];
    commentId = json['commentId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'text': text,
      'userId':userId,
      'userImage': userImage,
      'name' : name,
      'postid': postid,
      'commentId': commentId,
    };
  }
}
