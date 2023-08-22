import 'package:doltnow/app/data/services/storage/services.dart';
import 'package:doltnow/app/modules/home/bindings/home_bindings.dart';
import 'package:doltnow/app/modules/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DoltNow',
      home: const HomeView(),
      initialBinding: HomeBindings(),
      builder: EasyLoading.init(),
    );
  }
}
