// ignore_for_file: unused_local_variable

import 'package:doltnow/app/core/utils/extensions.dart';
import 'package:doltnow/app/modules/home/controller/home_controller.dart';
import 'package:doltnow/app/widgets/icons.dart';
import 'package:flutter/material.dart';
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
                    TextFormField(
                      controller: homecontroller.editController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Task',
                        border: OutlineInputBorder(),
                      ),
                    )
                  ],
                ),
              ));
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
