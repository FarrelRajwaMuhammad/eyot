import 'package:eyot/feature/dashboard/domain/entities/category_data_entity.dart';
import 'package:eyot/feature/dashboard/domain/entities/task_data_entity.dart';
import 'package:eyot/feature/dashboard/domain/repository/remote_repository.dart';

class taskUseCase {
  final TaskRepository repository;

  taskUseCase({required this.repository});

  Future<List<TaskEntity>> call(String userId) async {
    return await repository.getTasks(userId);
  }

  Future<List<CategoryEntity>> getCategory() async {
    return await repository.getCategory();
  }
}

