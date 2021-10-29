class CommentModel {
  String? text;
  String? dateTime;
  String? postid;
  String? userId;
  String? userImage;

  CommentModel({this.text, this.userImage,this.dateTime,this.userId,this.postid});

  CommentModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    text = json['text'];
    userId = json['userId'];
    userImage = json['userImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'text': text,
      'userId':userId,
      'userImage': userImage,
    };
  }
}
