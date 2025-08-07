import 'package:eyot/feature/dashboard/data/datasource/remote_datasource.dart';
import 'package:eyot/feature/dashboard/data/model/remote_task_model.dart';
import 'package:eyot/feature/dashboard/domain/entities/task_data_entity.dart';
import 'package:eyot/feature/dashboard/domain/repository/remote_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final RemoteDatasourceImpl remoteDatasource;

  TaskRepositoryImpl(this.remoteDatasource);

  @override
  Future<void> addTask(TaskEntity task) {
    final model = TaskModel(
      id: task.id,
      title: task.title,
      remindAt: task.remindAt,
      isDone: task.isDone,
      category: task.category,
      priority: task.priority,
      userId: task.userId,
    );
    return remoteDatasource.addTask(model);
  }

  @override
  Future<List<TaskEntity>> getTasks(String userId) async {
    final models = await remoteDatasource.getTasks(userId);
    return models
        .map((model) => TaskEntity(
              id: model.id,
              title: model.title,
              remindAt: model.remindAt,
              isDone: model.isDone,
              category: model.category,
              priority: model.priority,
              userId: model.userId,
            ))
        .toList();
  }
}
