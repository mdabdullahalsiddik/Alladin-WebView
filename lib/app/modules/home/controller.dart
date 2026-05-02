import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  final String url = "https://alladin134-com.lovable.app/";

  RxBool isLoading = true.obs;
  RxBool hasInternetConnection = true.obs;

  InAppWebViewController? webViewController;

  void setController(InAppWebViewController controller) {
    webViewController = controller;
  }
}
