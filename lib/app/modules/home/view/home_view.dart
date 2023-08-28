// ignore_for_file: sort_child_properties_last

import 'package:doltnow/app/core/utils/extensions.dart';
import 'package:doltnow/app/core/values/colors.dart';
import 'package:doltnow/app/data/models/task.dart';
import 'package:doltnow/app/modules/home/controller/home_controller.dart';
import 'package:doltnow/app/widgets/new_card.dart';
import 'package:doltnow/app/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../widgets/add_details.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text(
                'My List',
                style: TextStyle(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(
              () => GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  ...controller.tasks
                      .map((element) => LongPressDraggable(
                            data: element,
                            onDragStarted: () => controller.deleteTask(true),
                            onDraggableCanceled: (_, __) =>
                                controller.deleteTask(false),
                            onDragEnd: (_) => controller.deleteTask(false),
                            child: TaskCard(task: element),
                            feedback: Opacity(
                              opacity: 0.8,
                              child: TaskCard(task: element),
                            ),
                          ))
                      .toList(),
                  NewCard(),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(builder: (_, __, ___) {
        return Obx(
          () => FloatingActionButton(
            backgroundColor: controller.deleting.value ? Colors.red : green,
            onPressed: () {
              if (controller.tasks.isNotEmpty) {
                Get.to(
                  () => AddDetails(),
                  transition: Transition.rightToLeft,
                );
              } else {
                EasyLoading.showInfo('Add a task first');
              }
            },
            child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
          ),
        );
      }, onAccept: (Task task) {
        controller.removeTask(task);
        EasyLoading.showSuccess('Task Deleted');
      }),
    );
  }
}
