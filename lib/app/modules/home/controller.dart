import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  final String url = "https://vidsnap134-com.lovable.app/";

  RxBool isLoading = true.obs;
  RxBool hasInternetConnection = true.obs;

  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    await [Permission.camera, Permission.photos, Permission.storage, Permission.mediaLibrary, Permission.microphone, Permission.videos].request();
  }

  void setController(InAppWebViewController controller) {
    webViewController = controller;
  }
}
