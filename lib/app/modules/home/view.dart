import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import 'controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return SafeArea(
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

                onLoadStart: (controllerWeb, url) {
                  controller.isLoading.value = true;
                },

                onLoadStop: (controllerWeb, url) {
                  controller.isLoading.value = false;
                },

                /// 🔥 FILE UPLOAD FIX (MAIN PART)
              ),

              /// ⏳ Loading
              if (controller.isLoading.value)
                Container(
                  color: Colors.white,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        }),
      ),
    );
  }
}
