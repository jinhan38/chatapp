class ChatModel {
  String name;
  String icon;
  bool isGroup;
  String time;
  String currentMessage;
  String status;
  bool selected;
  int id;

  ChatModel(
    this.name,
    this.icon,
    this.isGroup,
    this.time,
    this.currentMessage,
    this.status, {
    this.selected = false,
    this.id = 0,
  });

  @override
  String toString() {
    return 'ChatModel{name: $name, icon: $icon, isGroup: $isGroup, time: $time, currentMessage: $currentMessage, status: $status, selected: $selected}';
  }
}
