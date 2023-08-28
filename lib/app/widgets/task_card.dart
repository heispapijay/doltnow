import 'package:doltnow/app/core/utils/extensions.dart';
import 'package:doltnow/app/data/models/task.dart';
import 'package:doltnow/app/modules/detail/detail_view.dart';
import 'package:doltnow/app/modules/home/controller/home_controller.dart';
import 'package:doltnow/app/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  TaskCard({super.key, required this.task});

  final homecontroller = Get.find<HomeController>();
  final Task task;

  @override
  Widget build(BuildContext context) {
    var squareWidth = Get.width - 12.0.wp;
    final color = HexColor.fromHex(task.color);
    return GestureDetector(
      onTap: () {
        homecontroller.changeTask(task);
        homecontroller.changeTodos(task.todos ?? []);
        Get.to(() => DetailView());
      },
      child: Container(
        margin: EdgeInsets.all(3.0.wp),
        width: squareWidth / 2,
        height: squareWidth / 2,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              //color: Colors.black.withOpacity(0.1),
              color: Colors.grey[300]!,
              blurRadius: 7,
              //blurRadius: 4.0,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps: 100,
              currentStep: 80,
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                //colors: [color, color],
                colors: [color.withOpacity(0.5), color],
              ),
              unselectedGradientColor: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                //colors: [color, color],
                colors: [Colors.white, Colors.white],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Icon(
                IconData(task.icon, fontFamily: 'MaterialIcons'),
                color: color,
                //size: 24.0.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  vSpace(2.0.wp),
                  Text(
                    '${task.todos?.length ?? 0} Tasks',
                    style: TextStyle(
                      fontSize: 12.0.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
