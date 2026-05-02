import 'dart:developer';

import 'package:alladin/app/core/utils/network_checker.dart';
import 'package:alladin/app/core/utils/settings.dart';
import 'package:alladin/app/routes/app_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashController extends GetxController {
  RxString appVersion = ''.obs;
  var status;
  scheduleNavigationToNextScreen() async {
    fetchAppVersion();

    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed(AppRoutes.home);
  }

  void fetchAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    appVersion.value = '${info.version}';
    // appVersion.value = '${info.version} + ${info.buildNumber}';
    log("=------${appVersion.value}------------");
  }

  void setAppSettings({required BuildContext context}) async {
    AppSettings.easyloadingSetting(context: context);
    AppSettings.appSafeAreaColorControl(context: context);
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (await internetCheck()) {
        await getData();
      }
    });

    super.onInit();
  }

  Future<void> getData() async {
    await checkForUpdate();

    await scheduleNavigationToNextScreen();
  }

  Future<bool> internetCheck() async {
    final hasConnection = await ConnectionChecker.checkConnection();

    if (!hasConnection) {
      Get.offAllNamed(AppRoutes.noInternet);
      return false;
    }
    return true;
  }

  // -------------------- APP UPDATE --------------------
  Future<void> checkForUpdate() async {
    try {
      if (kDebugMode) {
        log("Skip update check in debug mode");
        return;
      }

      final AppUpdateInfo info = await InAppUpdate.checkForUpdate();

      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        if (info.immediateUpdateAllowed) {
          await InAppUpdate.performImmediateUpdate();
        } else if (info.flexibleUpdateAllowed) {
          await InAppUpdate.startFlexibleUpdate();
          await InAppUpdate.completeFlexibleUpdate();
        }
      }
    } catch (e) {
      log("Update Error: $e");
    }
  }
}
