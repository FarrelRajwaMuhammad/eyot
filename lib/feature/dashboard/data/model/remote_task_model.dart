class TaskModel {
  final String id;
  final String title;
  final DateTime remindAt;
  final String category;
  final String priority;
  final String userId;
  final bool isDone;

  TaskModel({
    required this.id,
    required this.title,
    required this.category,
    required this.priority,
    required this.userId,
    required this.remindAt,
    required this.isDone,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      priority: json['priority'],
      userId: json['user_id'],
      isDone: json['is_done'],
      remindAt: DateTime.parse(json['remind_at']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'priority': priority,
      'user_id': userId,
      'is_done': isDone,
      'remind_at': remindAt.toIso8601String(),
    };
  }
}
