import 'package:doltnow/app/core/utils/extensions.dart';
import 'package:doltnow/app/modules/home/controller/home_controller.dart';
import 'package:doltnow/app/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DetailView extends StatelessWidget {
  DetailView({super.key});
  final homecontroller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    var task = homecontroller.task.value!;
    var color = HexColor.fromHex(task.color);
    return Scaffold(
      body: Form(
        key: homecontroller.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      homecontroller.changeTask(null);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
              child: Row(
                children: [
                  Icon(
                    IconData(
                      task.icon,
                      fontFamily: 'MaterialIcons',
                    ),
                    color: color,
                    //size: 40.0.sp
                  ),
                  hSpace(3.0.wp),
                  Text(
                    task.title,
                    style: TextStyle(
                        fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Obx(
              () {
                var totalTodos = homecontroller.doingTodos.length +
                    homecontroller.doneTodos.length;
                return Padding(
                  padding: EdgeInsets.only(
                      left: 17.5.wp, right: 16.0.wp, top: 3.0.wp),
                  child: Row(
                    children: [
                      Text(
                        '$totalTodos Tasks',
                        style: TextStyle(
                          fontSize: 12.0.sp,
                          color: Colors.grey,
                        ),
                      ),
                      hSpace(3.0.wp),
                      Expanded(
                        child: StepProgressIndicator(
                          totalSteps: totalTodos == 0 ? 1 : totalTodos,
                          currentStep: homecontroller.doneTodos.length,
                          size: 5,
                          padding: 0,
                          selectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            //colors: [color, color],
                            colors: [color.withOpacity(0.5), color],
                          ),
                          unselectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            //colors: [color, color],
                            colors: [Colors.grey[300]!, Colors.grey[300]!],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 5.0.wp),
              child: TextFormField(
                controller: homecontroller.editController,
                autofocus: true,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.grey[300],
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (homecontroller.formKey.currentState!.validate()) {
                        var sucess = homecontroller
                            .addTodo(homecontroller.editController.text);
                        if (sucess) {
                          EasyLoading.showSuccess('Todo added');
                        } else {
                          EasyLoading.showError('Todo already exists');
                        }
                        homecontroller.editController.clear();
                        //homecontroller.addTodo();
                      }
                    },
                    icon: const Icon(Icons.done),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your todo text';
                  }
                  return null;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
