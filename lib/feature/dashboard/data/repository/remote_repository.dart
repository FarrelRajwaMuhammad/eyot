import 'package:eyot/feature/dashboard/data/datasource/remote_datasource.dart';
import 'package:eyot/feature/dashboard/data/model/remote_task_model.dart';
import 'package:eyot/feature/dashboard/domain/entities/category_data_entity.dart';
import 'package:eyot/feature/dashboard/domain/entities/task_data_entity.dart';
import 'package:eyot/feature/dashboard/domain/repository/remote_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final RemoteDatasourceImpl remoteDatasource;

  TaskRepositoryImpl(this.remoteDatasource);

  @override
  Future<void> addTask(TaskEntity task) {
    final model = TaskModel(
      title: task.title,
      remindAt: task.remindAt,
      isDone: task.isDone,
      priority: task.priority,
      userId: task.userId,
      note: task.note,
      CategoryId: task.CategoryId,
    );
    return remoteDatasource.addTask(model);
  }

  @override
  Future<List<TaskEntity>> getTasks(String userId) async {
    final models = await remoteDatasource.getTasks(userId);
    return models
        .map((model) => TaskEntity(
              title: model.title,
              remindAt: model.remindAt,
              isDone: model.isDone,
              priority: model.priority,
              userId: model.userId,
              note: model.note,
              CategoryId: model.CategoryId,
            ))
        .toList();
  }

  @override
  Future<List<CategoryEntity>> getCategory() async {
    final models = await remoteDatasource.getCategory();
    return models
        .map((model) => CategoryEntity(
            CategoryId: model.CategoryId, namaCategory: model.categoryName))
        .toList();
  }
}
