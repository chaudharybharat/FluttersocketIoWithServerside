class ChatModel {
  String? message;
  String? senderId;
  String? receiverId;
  String? roomId;

  ChatModel({this.message, this.senderId, this.receiverId, this.roomId});

  ChatModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    roomId = json['roomId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['senderId'] = this.senderId;
    data['receiverId'] = this.receiverId;
    data['roomId'] = this.roomId;
    return data;
  }
}
