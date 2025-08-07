import 'dart:async';

import 'package:eyot/feature/dashboard/domain/entities/task_data_entity.dart';
import 'package:eyot/feature/dashboard/domain/usecase/remote_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  final taskUseCase TaskUseCase;

  HomeController({required this.TaskUseCase});

  var tasks = <TaskEntity>[].obs;

  @override
  void onInit() {
    super.onInit();

    final user = Supabase.instance.client.auth.currentUser;

    if (user != null) {
      userId.value = user.id;
      print('✅ userId berhasil diambil: ${userId.value}');
      getTasks();
    } else {
      print('⚠️ Belum login atau user null');
    }
  }

  Future<void> getTasks() async {
    final result = await TaskUseCase(userId.value);
    tasks.value = result;
  }

  var userId = ''.obs;
  var title = ''.obs;
  var category = ''.obs;
  var priority = ''.obs;
  var remindAt = DateTime.now().obs;
  var countdownText = ''.obs;

  Future<void> loadTasks(String userId) async {
    final result = await TaskUseCase(userId);
    tasks.assignAll(result);
  }

  Future<void> addTask(String userId) async {
    final newTask = TaskEntity(
      id: Uuid().v4(),
      title: title.value,
      category: category.value,
      priority: priority.value,
      userId: userId,
      remindAt: remindAt.value,
      isDone: false,
    );

    await TaskUseCase.repository.addTask(newTask);
    await loadTasks(userId);
    Get.back();
    Get.snackbar("Success", "Task berhasil ditambahkan");
  }

  void clearFields() {
    title.value = '';
    category.value = '';
    priority.value = '';
    remindAt.value = DateTime.now();
  }

  void startCountdown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final remaining = remindAt.value.difference(now);
      if (remaining.isNegative) {
        countdownText.value = 'Waktu habis';
        timer.cancel();
      } else {
        countdownText.value =
            '${remaining.inHours.toString().padLeft(2, '0')}:${(remaining.inMinutes % 60).toString().padLeft(2, '0')}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}';
      }
    });
  }
}
