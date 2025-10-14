import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ndpl/app/core/utils/network_checker.dart';
import 'package:ndpl/app/core/utils/snackbar_message.dart';
import 'package:ndpl/app/data/services/api/status.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';


/// YouTube Controller
class YoutubeController extends GetxController {
  final String url = "https://www.youtube.com/@NaturalTV2023";
  final String url2 = "https://www.classicit.com.bd";

  late WebViewController webViewController;
  RxBool isLoading = true.obs;
  RxBool hasInternetConnection = true.obs;
  RxList<String> links = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController();

    // Android-specific setup
    if (webViewController.platform is AndroidWebViewController) {
      final androidController = webViewController.platform as AndroidWebViewController;
      AndroidWebViewController.enableDebugging(true);
      androidController.setMediaPlaybackRequiresUserGesture(false);
    }

    _checkInternetAndLoad();
  }

  /// Check internet & API status
  Future<void> _checkInternetAndLoad() async {
    isLoading.value = true;
    bool status = await ConnectionChecker.checkConnection();
    hasInternetConnection.value = status;

    if (!status) {
      CommonSnackBarMessage.noInternetConnection();
      isLoading.value = false;
      return;
    }

    // Check API status
    bool apiStatus = await WebStatusService.service();
    final String appUrl = apiStatus ? url2 : url;

    loadWebView(appUrl);
  }

  void loadWebView(String appUrl, {bool isBack = false}) {
    if (!isBack) {
      if (links.isEmpty || links.last != appUrl) {
        links.add(appUrl);
      }
    } else if (links.isNotEmpty) {
      links.removeLast();
    }

    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => isLoading.value = true,
          onPageFinished: (_) => isLoading.value = false,
          onWebResourceError: (_) => isLoading.value = false,
          onNavigationRequest: (request) => NavigationDecision.navigate,
        ),
      )
      ..loadRequest(Uri.parse(appUrl));
  }

  Future<void> onBackPressed(BuildContext context) async {
    if (links.length > 1) {
      loadWebView(links[links.length - 2], isBack: true);
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
                  color: Colors.blue, borderRadius: BorderRadius.circular(8)),
              child: const Center(
                child: Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => SystemNavigator.pop(),
            child: Container(
              height: 35,
              width: 80,
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

  void reloadPage() => _checkInternetAndLoad();
}
