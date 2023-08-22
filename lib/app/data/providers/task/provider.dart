import 'dart:convert';

import 'package:doltnow/app/core/utils/keys.dart';
import 'package:doltnow/app/data/models/task.dart';
import 'package:doltnow/app/data/services/storage/services.dart';
import 'package:get/get.dart';

class TaskProvider {
  final StorageService _storage = Get.find<StorageService>();

// {
//   'tasks': [
//     {'title': 'Work',
//     'color': '#FFC542',
//     'icon': 0xe123'}
//   ]
// }
  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
