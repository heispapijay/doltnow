// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:doltnow/app/core/utils/extensions.dart';
import 'package:doltnow/app/core/values/colors.dart';
import 'package:doltnow/app/data/models/task.dart';
import 'package:doltnow/app/modules/home/controller/home_controller.dart';
import 'package:doltnow/app/widgets/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';

class NewCard extends StatelessWidget {
  final homecontroller = Get.find<HomeController>();
  NewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
              titlePadding: EdgeInsets.symmetric(vertical: 8.0.wp),
              radius: 5,
              title: 'Add New Task',
              content: Form(
                key: homecontroller.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                      child: TextFormField(
                        controller: homecontroller.editController,
                        decoration: const InputDecoration(
                          hintText: 'Enter Task Title',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                      child: Wrap(
                        spacing: 2.0.wp,
                        children: icons
                            .map((e) => Obx(
                                  () {
                                    final index = icons.indexOf(e);
                                    return ChoiceChip(
                                      backgroundColor: Colors.white,
                                      selectedColor: Colors.grey[200],
                                      pressElevation: 0,
                                      label: e,
                                      selected:
                                          homecontroller.chipIndex.value ==
                                              index,
                                      onSelected: (bool selected) {
                                        homecontroller.chipIndex.value =
                                            selected ? index : 0;
                                      },
                                    );
                                  },
                                ))
                            .toList(),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: const Size(150, 40),
                      ),
                      onPressed: () {
                        if (homecontroller.formKey.currentState!.validate()) {
                          int icon = icons[homecontroller.chipIndex.value]
                              .icon!
                              .codePoint;
                          String color = icons[homecontroller.chipIndex.value]
                              .color!
                              .toHex();
                          var task = Task(
                            title: homecontroller.editController.text,
                            icon: icon,
                            color: color,
                          );
                          Get.back();
                          homecontroller.addTask(task)
                              //homecontroller.tasks.add(task)
                              ? EasyLoading.showSuccess('Task Added')
                              : EasyLoading.showError('Task Not Added');
                          Get.back();
                        }
                      },
                      child: const Text(
                        'Add Task',
                      ),
                    ),
                  ],
                ),
              ));

          homecontroller.editController.clear();
          homecontroller.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
