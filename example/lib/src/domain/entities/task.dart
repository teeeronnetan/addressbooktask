class Task {
  final String uid;
  String description;
  bool isCheck;

  Task(this.uid, this.description, this.isCheck);

  Map toJson() => {'uid': uid, 'description': description, 'isCheck': isCheck};
}
