import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndpl/app/modules/home/controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Home View
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          await controller.onBackPressed(context);
          return false;
        },
        child: Obx(() {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                // Show WebView only if URL is loaded
                if (controller.links.isNotEmpty)
                  Positioned.fill(
                    child: WebViewWidget(controller: controller.webViewController),
                  ),

                // Loading indicator
                if (controller.isLoading.value)
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/logo.png', // Update your asset path
                            height: 250,
                            width: 250,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 20),
                          const CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ),

                // No internet
                if (!controller.hasInternetConnection.value &&
                    !controller.isLoading.value)
                  Container(
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(Icons.wifi_off,
                              color: Colors.red, size: 50),
                          const SizedBox(height: 10),
                          const Text(
                            "Please, Check Internet Connection",
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 15),
                          ),
                          SizedBox(height: MediaQuery.sizeOf(context).height / 3),
                          InkWell(
                            onTap: controller.checkInternetAndLoad,
                            child: const Icon(Icons.refresh, size: 40),
                          ),
                          const Text(
                            "Reload",
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 15),
                          ),
                          SizedBox(
                              height: MediaQuery.sizeOf(context).height / 10),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
