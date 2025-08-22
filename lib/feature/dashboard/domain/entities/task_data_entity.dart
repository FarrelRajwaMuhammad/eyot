class TaskEntity {
  final String title;
  final DateTime remindAt;
  final bool isDone;
  final String priority;
  final String userId;
  final String? note;
  final int CategoryId;

  TaskEntity(
      {required this.title,
      required this.remindAt,
      required this.isDone,
      required this.priority,
      required this.userId,
      this.note,
      required this.CategoryId});
}
