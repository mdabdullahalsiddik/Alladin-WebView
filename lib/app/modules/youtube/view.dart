import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndpl/app/core/constant/assets.dart';
import 'package:ndpl/app/modules/youtube/controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YouTubeView extends StatelessWidget {
  const YouTubeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(YoutubeController());

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          await controller.onBackPressed(context);
          return false;
        },
        child: Obx(() {
          // Loading overlay
          if (controller.isLoading.value) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.logo,
                      height: 250,
                      width: 250,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),
                    const CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          }

          // No internet
          if (!controller.hasInternetConnection.value) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off, color: Colors.red, size: 50),
                    const SizedBox(height: 10),
                    const Text(
                      "Please, Check Internet Connection",
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: controller.reloadPage,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Reload"),
                    ),
                  ],
                ),
              ),
            );
          }

          // Show WebView only if URL is loaded
          if (controller.links.isNotEmpty) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: WebViewWidget(controller: controller.webViewController),
            );
          }

          // Default fallback (blank)
          return const Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox.shrink(),
          );
        }),
      ),
    );
  }
}
