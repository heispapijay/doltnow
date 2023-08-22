import 'package:doltnow/app/data/models/task.dart';
import 'package:doltnow/app/data/services/storage/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final tasks = <Task>[].obs;
  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();

  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    super.onClose();
  }
}
