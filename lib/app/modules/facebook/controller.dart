import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:ndpl/app/core/utils/network_checker.dart';
import 'package:ndpl/app/core/utils/snackbar_message.dart';

class FacebookController extends GetxController {
  late WebViewController webViewController;

  RxBool isLoading = true.obs;
  RxBool hasInternetConnection = true.obs;
  RxList<String> historyLinks = <String>[].obs;

  final String url = "https://www.facebook.com/share/17KJUMx8vC";

  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController();
    _checkInternetAndLoad();

    if (webViewController.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (webViewController.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
  }

  Future<void> _checkInternetAndLoad() async {
    isLoading.value = true;

    bool status = await ConnectionChecker.checkConnection();
    await Future.delayed(const Duration(milliseconds: 500));

    hasInternetConnection.value = status;

    if (hasInternetConnection.value) {
      loadWebView(url);
    } else {
      CommonSnackBarMessage.noInternetConnection();
    }

    isLoading.value = false;
  }

  void loadWebView(String url, {bool isBack = false}) {
    if (!isBack) {
      historyLinks.add(url);
    } else if (historyLinks.isNotEmpty) {
      historyLinks.removeLast();
    }

    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (_) {},
          onPageStarted: (_) {},
          onPageFinished: (_) {},
          onWebResourceError: (_) {},
          onNavigationRequest: (request) => NavigationDecision.navigate,
        ),
      )
      ..setUserAgent(
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
        'AppleWebKit/537.36 (KHTML, like Gecko) '
        'Chrome/115.0 Safari/537.36',
      )
      ..loadRequest(Uri.parse(url));
  }

  Future<void> onBackPressed() async {
    if (historyLinks.length > 1) {
      loadWebView(historyLinks.last, isBack: true);
    } else {
      Get.defaultDialog(
        title: 'Confirmation',
        content: const Text('Do you want to exit the app?'),
        actions: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              height: 35,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Get.back(closeOverlays: true),
            child: Container(
              height: 35,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('Yes', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      );
    }
  }

  void reloadPage() => _checkInternetAndLoad();
}
