import 'package:doltnow/app/core/utils/extensions.dart';
import 'package:doltnow/app/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../modules/home/controller/home_controller.dart';

class AddDetails extends StatelessWidget {
  AddDetails({super.key});
  final homecontroller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: homecontroller.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      homecontroller.editController.clear();
                      homecontroller.changeTask(null);
                    },
                    icon: const Icon(Icons.close),
                  ),
                  TextButton(
                    onPressed: () {
                      if (homecontroller.formKey.currentState!.validate()) {
                        if (homecontroller.task.value == null) {
                          EasyLoading.showError('Please select a task type');
                        } else {
                          var success = homecontroller.updateTask(
                            homecontroller.editController.text.trim(),
                            homecontroller.task.value!,
                          );
                          if (success) {
                            EasyLoading.showSuccess('Task added successfully');
                            Get.back();
                            //homecontroller.editController.clear();
                            homecontroller.changeTask(null);
                          } else {
                            EasyLoading.showError('List item already exists');
                          }
                          homecontroller.editController.clear();
                        }
                      }
                    },
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Text(
                'Add New Task',
                style: TextStyle(
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: homecontroller.editController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                  ),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 5.0.wp, left: 5.0.wp, right: 5.0.wp, bottom: 2.0.wp),
              child: Text(
                'Add to List',
                style: TextStyle(
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...homecontroller.tasks
                .map((element) => Obx(
                      () => InkWell(
                        onTap: () {
                          homecontroller.changeTask(element);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0.wp, horizontal: 5.0.wp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                      IconData(
                                        element.icon,
                                        fontFamily: 'MaterialIcons',
                                      ),
                                      color: HexColor.fromHex(element.color)),
                                  hSpace(3.0.wp),
                                  Text(
                                    element.title,
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              if (homecontroller.task.value == element)
                                const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
