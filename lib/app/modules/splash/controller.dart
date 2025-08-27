import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndpl/app/core/utils/settings.dart';
import 'package:ndpl/app/routes/app_route.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../data/local/storage.dart';

class SplashController extends GetxController {
  RxString appVersion = ''.obs;
  var status;
  scheduleNavigationToNextScreen() async {
    fetchAppVersion();

    await Future.delayed(const Duration(seconds: 3));

    status = await LocalData().readData(key: "isLogin");
    var isWelcome = await LocalData().readData(key: 'isWelcome');
    log("===++===$isWelcome=========++====");
    log("======$status=============");

    if (isWelcome == "true") {
      if (status == "true") {
        Get.offAllNamed(AppRoutes.navBar);
      } else {
        // Get.offAllNamed(AppRoutes.login);
        Get.offAllNamed(AppRoutes.navBar);
      }
    } else {
      Get.offAllNamed(AppRoutes.welcome);
    }
  }

  void fetchAppVersion() async {
    final info = await PackageInfo.fromPlatform();

    appVersion.value = '${info.version} + ${info.buildNumber}';
    log("=------${appVersion.value}------------");
  }

  void setAppSettings({required BuildContext context}) async {
    AppSettings.easyloadingSetting(context: context);
    AppSettings.appSafeAreaColorControl(context: context);
  }

  @override
  void onInit() {
    scheduleNavigationToNextScreen();

    super.onInit();
  }
}
