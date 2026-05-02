import 'package:alladin/app/core/utils/network_checker.dart';
import 'package:alladin/app/routes/app_route.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final String url = "https://alladin.com.bd/";

  RxBool isLoading = true.obs;
  RxBool hasInternetConnection = true.obs;

  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    checkInternetAndLoad();
  }

  void setController(InAppWebViewController controller) {
    webViewController = controller;
  }

  Future<void> checkInternetAndLoad() async {
    final hasConnection = await ConnectionChecker.checkConnection();

    if (!hasConnection) {
      hasInternetConnection.value = false;
      Get.offAllNamed(AppRoutes.noInternet);
    } else {
      hasInternetConnection.value = true;
    }
  }
}
