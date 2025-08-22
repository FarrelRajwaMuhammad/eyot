import 'dart:async';
import 'package:eyot/feature/dashboard/domain/entities/category_data_entity.dart';
import 'package:eyot/feature/dashboard/domain/entities/task_data_entity.dart';
import 'package:eyot/feature/dashboard/domain/usecase/remote_repository.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  final taskUseCase TaskUseCase;

  HomeController({required this.TaskUseCase});

  var tasks = <TaskEntity>[].obs;
  var category = <CategoryEntity>[].obs;
  var selectedCategory = Rx<CategoryEntity?>(null);
  var selectedTaskIndex = RxnInt();

  @override
  void onInit() {
    super.onInit();

    final user = Supabase.instance.client.auth.currentUser;

    if (user != null) {
      userId.value = user.id;
      print('✅ userId berhasil diambil: ${userId.value}');
      getTasks();
      getCategory();
    } else {
      print('⚠️ Belum login atau user null');
    }
  }

  Future<void> getTasks() async {
    final result = await TaskUseCase(userId.value);
    tasks.value = result;
  }

  void toggleSelected(int index) {
    if (selectedTaskIndex.value == index) {
      selectedTaskIndex.value = null;
    } else {
      selectedTaskIndex.value = index;
    }
  }

  Future<void> getCategory() async {
    try {
      log("getCategory() DIPANGGIL");
      final result = await TaskUseCase.getCategory();
      log("HASIL: $result");

      category.assignAll(result);
      log("CATEGORY terisi ${category.length} data");
    } catch (e, s) {
      log("❌ ERROR getCategory: $e");
      log("STACKTRACE: $s");
    } finally {
      log("getCategory() SELESAI");
    }
  }

  var userId = ''.obs;
  var title = ''.obs;
  var priority = ''.obs;
  var remindAt = DateTime.now().obs;
  var countdownText = ''.obs;
  var note = ''.obs;

  Future<void> loadTasks(String userId) async {
    final result = await TaskUseCase(userId);
    tasks.assignAll(result);
  }

  Future<void> addTask(String userId) async {
    if (selectedCategory.value == null) {
      Get.snackbar("Error", "Silahkan pilih kategori");
      return;
    }

    final newTask = TaskEntity(
      title: title.value,
      priority: priority.value,
      userId: userId,
      remindAt: remindAt.value,
      isDone: false,
      note: note.value,
      CategoryId: selectedCategory.value!.CategoryId,
    );

    await TaskUseCase.repository.addTask(newTask);
    await loadTasks(userId);
    Get.back();
    Get.snackbar("Success", "Task berhasil ditambahkan");
  }

  void clearFields() {
    title.value = '';
    priority.value = '';
    remindAt.value = DateTime.now();
  }
}
