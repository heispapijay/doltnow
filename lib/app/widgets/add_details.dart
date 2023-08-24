import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/home/controller/home_controller.dart';

class AddDetails extends StatelessWidget {
  AddDetails({super.key});
  final homecontroller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.close),
        ),
      ]),
    );
  }
}
