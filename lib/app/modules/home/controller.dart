import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ndpl/app/core/utils/network_checker.dart';
import 'package:ndpl/app/core/utils/snackbar_message.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class HomeController extends GetxController {
  final String url = "https://naturaldpl.com";

  late WebViewController webViewController;
  RxBool isLoading = true.obs;
  RxBool hasInternetConnection = true.obs;
  RxList<String> links = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Initialize WebViewController with correct Android setup
    webViewController = WebViewController();

    if (webViewController.platform is AndroidWebViewController) {
      final androidController =
          webViewController.platform as AndroidWebViewController;
      AndroidWebViewController.enableDebugging(true);
      androidController.setMediaPlaybackRequiresUserGesture(false);
    }

    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {},
          onPageStarted: (String url) {
            isLoading.value = true;
            if (links.isEmpty || links.last != url) {
              links.add(url);
            }
          },
          onPageFinished: (String url) => isLoading.value = false,
          onWebResourceError: (error) => isLoading.value = false,
          onNavigationRequest: (request) => NavigationDecision.navigate,
        ),
      );

    checkInternetAndLoad();
  }

  Future<void> checkInternetAndLoad() async {
    isLoading.value = true;
    bool status = await ConnectionChecker.checkConnection();
    await Future.delayed(const Duration(seconds: 1));
    hasInternetConnection.value = status;

    if (status) {
      webViewController.loadRequest(Uri.parse(url));
    } else {
      CommonSnackBarMessage.noInternetConnection();
      isLoading.value = false;
    }
  }

  Future<void> onBackPressed(BuildContext context) async {
    if (links.length > 1) {
      links.removeLast();
      webViewController.loadRequest(Uri.parse(links.last));
    } else {
      Get.defaultDialog(
        title: 'Confirmation',
        titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        content: const Text('Do you want to exit the app?'),
        actions: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              height: 30,
              width: 70,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(8)),
              child: const Center(
                child: Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: () => SystemNavigator.pop(),
            child: Container(
              height: 30,
              width: 70,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(8)),
              child: const Center(
                child: Text('Yes', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      );
    }
  }
}
