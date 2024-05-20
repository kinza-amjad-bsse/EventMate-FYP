enum MessageType {
  text,
  image,
  video,
  audio,
}

class ChatModel {
  final String senderId, receiverId, message, timestamp;
  final bool unread;
  final MessageType type;

  ChatModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    required this.type,
    required this.unread,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      timestamp: json['timestamp'],
      type: json['type'] == "text" ? MessageType.text : MessageType.image,
      unread: json['unread'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
      'type': type == MessageType.text ? "text" : "image",
      'unread': unread,
    };
  }
}
