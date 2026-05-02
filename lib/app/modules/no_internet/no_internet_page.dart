import 'package:alladin/app/core/utils/network_checker.dart';
import 'package:alladin/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './no_internet_controller.dart';

class NoInternetPage extends GetView<NoInternetController> {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.signal_wifi_off, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            const Text('No Internet Connection', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool connected = await ConnectionChecker.checkConnection();
                controller.hasInternet.value = connected;

                if (connected && Get.currentRoute == AppRoutes.noInternet) {
                  Get.back();
                }
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
