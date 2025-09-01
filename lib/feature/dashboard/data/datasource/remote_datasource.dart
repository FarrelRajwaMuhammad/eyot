import 'package:eyot/feature/dashboard/data/model/remote_category_model.dart';
import 'package:eyot/feature/dashboard/data/model/remote_task_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RemoteDatasource {
  Future<void> addTask(TaskModel task);
  Future<List<TaskModel>> getTasks(String userId);
  Future<List<CategoryModel>> getCategory();
}

class RemoteDatasourceImpl implements RemoteDatasource {
  final SupabaseClient client;

  RemoteDatasourceImpl({required this.client});

  @override
  Future<void> addTask(TaskModel task) async {
    await client.from('task').insert(task.toJson());
  }

  Future<List<TaskModel>> getTasks(String userId) async {
    final response = await client
        .from('task')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return (response as List).map((json) => TaskModel.fromJson(json)).toList();
  }

  

  Future<List<CategoryModel>> getCategory() async {
    final response = await client.from('categories').select();
    print("RAW RESPONSE: $response");
    return (response as List)
        .map((json) => CategoryModel.fromJson(json))
        .toList();
  }
}
