import 'package:doltnow/app/data/providers/task/provider.dart';
import 'package:doltnow/app/data/services/storage/repository.dart';
import 'package:doltnow/app/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
