class TaskEntity {
  final String id;
  final String title;
  final DateTime remindAt;
  final bool isDone;
  final String category;
  final String priority;
  final String userId;

  TaskEntity({
    required this.id,
    required this.title,
    required this.remindAt,
    required this.isDone,
    required this.category,
    required this.priority,
    required this.userId,
  });
}
