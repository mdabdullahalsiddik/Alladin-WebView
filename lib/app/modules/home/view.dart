import 'dart:io';

import 'package:alladin/app/core/constant/assets.dart';
import 'package:alladin/app/core/utils/network_checker.dart';
import 'package:alladin/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import 'controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showExitDialog(context);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Obx(() {
            return Stack(
              children: [
                /// 🌐 WebView
                InAppWebView(
                  initialUrlRequest: URLRequest(url: WebUri(controller.url)),

                  initialSettings: InAppWebViewSettings(
                    javaScriptEnabled: true,
                    allowFileAccess: true,
                    allowContentAccess: true,
                    mediaPlaybackRequiresUserGesture: false,
                    allowsInlineMediaPlayback: true,
                  ),

                  onWebViewCreated: (webController) {
                    controller.setController(webController);
                  },

                  onLoadStart: (controllerWeb, url) async {
                    controller.isLoading.value = true;

                    final hasInternet = await ConnectionChecker.checkConnection();
                    if (!hasInternet) {
                      Get.offAllNamed(AppRoutes.noInternet);
                    }
                  },

                  onLoadStop: (controllerWeb, url) {
                    controller.isLoading.value = false;
                  },

                  onReceivedError: (controllerWeb, request, error) {
                    Get.offAllNamed(AppRoutes.noInternet);
                  },
                ),

                /// ⏳ Loading
                if (controller.isLoading.value)
                  Container(
                    color: Colors.white,
                    child: const Center(child: Image(image: AssetImage(AppAssets.logo), height: 100, width: 100)),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }

  void showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              insetPadding: const EdgeInsets.all(8),
              child: Container(
                width: constraints.maxWidth - 40,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // ✅ spacing এর সমস্যা ফিক্স
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Exit Confirmation',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    Text('Are you sure you want to exit the app?', style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (Platform.isAndroid) {
                              SystemNavigator.pop();
                            } else {
                              exit(0);
                            }
                          },
                          child: const Text("Exit", style: TextStyle(fontSize: 13, color: Colors.red)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
