class TaskModel {
  final String title;
  final DateTime remindAt;
  final String priority;
  final String userId;
  final bool isDone;
  final String? note;
  final int CategoryId;

  TaskModel(
      {required this.title,
      required this.priority,
      required this.userId,
      required this.remindAt,
      required this.isDone,
      this.note,
      required this.CategoryId});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        title: json['title'],
        priority: json['priority'],
        userId: json['user_id'],
        isDone: json['is_done'],
        remindAt: DateTime.parse(json['remind_at']),
        note: json['note'],
        CategoryId: json['category_id'] ?? 0);
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'priority': priority,
      'user_id': userId,
      'is_done': isDone,
      'remind_at': remindAt.toIso8601String(),
      'note': note,
      'category_id': CategoryId,
    };
  }
}
