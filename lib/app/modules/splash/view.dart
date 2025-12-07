import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wajibmotors/app/core/constant/assets.dart';
import 'package:wajibmotors/app/global_widgets/app_text.dart';
import 'package:wajibmotors/app/modules/splash/controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // App-wide setup (SafeArea, EasyLoading)
    controller.setAppSettings(context: context);

    // Trigger splash logic
    controller.scheduleNavigationToNextScreen();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset(AppAssets.logo, height: MediaQuery.of(context).size.height / 2.5)),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 30,
        child: Obx(() {
          if (controller.appVersion.isEmpty) {
            return const SizedBox();
          }
          return CustomText("App Version :  ${controller.appVersion}", color: Theme.of(context).primaryColor, align: TextAlign.end);
        }),
      ),
    );
  }
}
