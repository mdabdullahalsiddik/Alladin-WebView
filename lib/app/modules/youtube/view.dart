import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndpl/app/core/constant/assets.dart';
import 'package:ndpl/app/modules/youtube/controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YouTubeView extends StatelessWidget {
  const YouTubeView({super.key});

  @override
  Widget build(BuildContext context) {
    final YoutubeController controller = Get.put(YoutubeController());

    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvoked: (_) => controller.onBackPressed(context),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.logo,
                        height: 250, width: 250, fit: BoxFit.cover),
                    const SizedBox(height: 20),
                    const CircularProgressIndicator(color: Colors.blue),
                  ],
                ),
              ),
            );
          }

          if (!controller.hasInternetConnection.value) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(Icons.wifi_off, color: Colors.red, size: 50),
                    const SizedBox(height: 10),
                    const Text("Please, Check Internet Connection",
                        style:
                            TextStyle(color: Colors.blueGrey, fontSize: 15)),
                    SizedBox(height: MediaQuery.sizeOf(context).height / 3),
                    InkWell(
                      onTap: controller.checkInternetAndLoad,
                      child: const Icon(Icons.refresh, size: 40),
                    ),
                    const Text("Reload",
                        style:
                            TextStyle(color: Colors.blueGrey, fontSize: 15)),
                    SizedBox(height: MediaQuery.sizeOf(context).height / 10),
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            backgroundColor: Colors.white,
            body: WebViewWidget(controller: controller.webViewController),
          );
        }),
      ),
    );
  }
}
