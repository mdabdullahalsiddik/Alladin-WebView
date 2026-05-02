import 'dart:async';

import 'package:alladin/app/core/utils/network_checker.dart';
import 'package:alladin/app/routes/app_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NoInternetController extends GetxController {
  RxBool hasInternet = false.obs;
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  @override
  void onInit() {
    super.onInit();

    // Listen to connection changes
    _subscription = ConnectionChecker.connectivityStream.listen((event) {
      bool isConnected = event.isNotEmpty && event.first != ConnectivityResult.none;

      hasInternet.value = isConnected;

      if (isConnected && Get.currentRoute == AppRoutes.noInternet) {
        Get.back(); // return to previous page
      }

      if (!isConnected && Get.currentRoute != AppRoutes.noInternet) {
        Get.toNamed(AppRoutes.noInternet);
      }
    });

    // Check once when controller starts
    checkInitialConnection();
  }

  Future<void> checkInitialConnection() async {
    hasInternet.value = await ConnectionChecker.checkConnection();

    if (!hasInternet.value && Get.currentRoute != AppRoutes.noInternet) {
      Get.toNamed(AppRoutes.noInternet);
    }
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
