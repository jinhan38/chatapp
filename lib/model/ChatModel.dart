

class ChatModel{
  String name;
  String icon;
  bool isGroup;
  String time;
  String currentMessage;

  ChatModel(this.name, this.icon, this.isGroup, this.time, this.currentMessage);

  @override
  String toString() {
    return 'ChatModel{name: $name, icon: $icon, isGroup: $isGroup, time: $time, currentMessage: $currentMessage}';
  }
}
