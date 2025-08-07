import 'package:eyot/feature/dashboard/domain/entities/task_data_entity.dart';

abstract class TaskRepository {
  Future<void> addTask(TaskEntity task);
  Future<List<TaskEntity>> getTasks(String userId);
}