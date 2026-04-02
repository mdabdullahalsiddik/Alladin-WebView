import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidsnap/app/core/constant/assets.dart';
import 'package:vidsnap/app/modules/splash/controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    controller.setAppSettings(context: context);
    return Scaffold(
      body: Center(child: Image.asset(AppAssets.logo, height: 250, width: 250)),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 30,
          child: Obx(() {
            if (controller.appVersion.isEmpty) {
              return const SizedBox();
            }
            return Text(
              "App Version : ${controller.appVersion}",
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            );
          }),
        ),
      ),
    );
  }
}