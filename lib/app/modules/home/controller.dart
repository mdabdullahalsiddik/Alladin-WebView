import 'package:alladin/app/core/utils/network_checker.dart';
import 'package:alladin/app/routes/app_route.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final String url = "https://alladin134-com.lovable.app/";

  RxBool isLoading = true.obs;
  RxBool hasInternetConnection = true.obs;

  InAppWebViewController? webViewController;

  void setController(InAppWebViewController controller) {
    webViewController = controller;
  } 

    Future<bool> internetCheck() async {
    final hasConnection = await ConnectionChecker.checkConnection();

    if (!hasConnection) {
      Get.offAllNamed(AppRoutes.noInternet);
      return false;
    }
    return true;
  } 

}