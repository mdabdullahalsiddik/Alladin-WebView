import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vidsnap/app/core/utils/network_checker.dart';
import 'package:vidsnap/app/core/utils/snackbar_message.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

/// ✅ Request Camera + Microphone Permission
Future<void> requestPermissions() async {
  var cameraStatus = await Permission.camera.request();
  var micStatus = await Permission.microphone.request();

  if (cameraStatus.isGranted && micStatus.isGranted) {
    print("✅ Camera & Mic permission granted");
  } else {
    print("❌ Permission denied");
  }
}

/// HomeController for WebView
class HomeController extends GetxController {
  final String url = "https://vidsnap134.lovable.app";

  late WebViewController webViewController;

  RxBool isLoading = true.obs;
  RxBool hasInternetConnection = true.obs;
  RxList<String> links = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    initWebView();
    checkInternetAndLoad();
    requestPermissions(); // 🔥 important
  }

  /// ✅ Initialize WebView
  void initWebView() {
    webViewController = WebViewController();

    /// 🔥 Android specific setup
    if (webViewController.platform is AndroidWebViewController) {
      final androidController =
          webViewController.platform as AndroidWebViewController;

      AndroidWebViewController.enableDebugging(true);

      androidController
        ..setMediaPlaybackRequiresUserGesture(false)

        /// 🔥 VERY IMPORTANT (Camera/Mic अनुमति)
        ..setOnPlatformPermissionRequest((request) {
          request.grant();
        });
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

          onPageFinished: (String url) {
            isLoading.value = false;
          },

          onWebResourceError: (error) {
            isLoading.value = false;
          },

          onNavigationRequest: (request) {
            return NavigationDecision.navigate;
          },
        ),
      );
  }

  /// ✅ Check internet then load URL
  Future<void> checkInternetAndLoad() async {
    bool internetStatus = await ConnectionChecker.checkConnection();
    hasInternetConnection.value = internetStatus;

    if (!internetStatus) {
      await Future.delayed(const Duration(seconds: 1));
      CommonSnackBarMessage.noInternetConnection();
      return;
    }

    await Future.delayed(const Duration(seconds: 1));

    webViewController.loadRequest(Uri.parse(url));
  }

  /// ✅ Handle Back Button
  Future<void> onBackPressed(BuildContext context) async {
    if (links.length > 1) {
      links.removeLast();
      webViewController.loadRequest(Uri.parse(links.last));
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
            onTap: () => SystemNavigator.pop(),
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