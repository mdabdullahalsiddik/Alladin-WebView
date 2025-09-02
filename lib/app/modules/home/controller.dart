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
    webViewController = WebViewController();

    // Enable debugging and autoplay videos
    if (webViewController.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (webViewController.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    checkInternetAndLoad();
  }

  /// Check Internet & Load WebView
  Future<void> checkInternetAndLoad() async {
    isLoading.value = true;

    bool status = await ConnectionChecker.checkConnection();
    await Future.delayed(const Duration(seconds: 1));
    hasInternetConnection.value = status;

    if (hasInternetConnection.value) {
      loadWebView(appUrl: url);
    } else {
      CommonSnackBarMessage.noInternetConnection();
    }

    isLoading.value = false;
  }

  /// Load WebView
  void loadWebView({required String appUrl, bool? isBack}) {
    try {
      webViewController
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {},
            onPageStarted: (String url) {
              if (isBack == true) {
                if (links.isNotEmpty) links.removeLast();
              } else {
                links.add(appUrl);
                links.removeWhere((element) => element == url);
              }
            },
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(appUrl));
    } catch (e) {
      debugPrint('Error loading WebView: $e');
    }
  }

  /// Back Button Handling
  Future<void> onBackPressed(BuildContext context) async {
    if (links.isNotEmpty) {
      loadWebView(appUrl: links.last, isBack: true);
    } else {
      Get.defaultDialog(
        title: 'Confirmation',
        titleStyle:
            const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        content: const Text('Do you want to exit the app?'),
        actions: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              height: 30,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: () {
              SystemNavigator.pop();
            },
            child: Container(
              height: 30,
              width: 70,
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
}
