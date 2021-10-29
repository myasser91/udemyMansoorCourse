
class MessageModel {
 String? senderId;
 String?  receiverId;
 String? dateTime;
 String? text;
 String? messageimage;
  MessageModel(
      {this.senderId,
      this.receiverId,
      this.text,
      this.dateTime,
      this.messageimage,
      });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];
    messageimage = json['messageimage'];
   }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text': text,
      'messageimage': messageimage,
      
    };
  }
}
