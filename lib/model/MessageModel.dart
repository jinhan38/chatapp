class MessageModel {
  String type;
  String message;
  String time;

  MessageModel({
    required this.type,
    required this.message,
    required this.time,
  });

  @override
  String toString() {
    return 'MessageModel{type: $type, message: $message, time : $time}';
  }
}
