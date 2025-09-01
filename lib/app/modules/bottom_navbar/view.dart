import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/assets.dart';
import '../../global_widgets/app_text.dart';
import 'controller.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  const BottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() => controller.screenList[controller.selectedPos.value]),
        bottomNavigationBar: Container(
          height: 60,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildCard(
                      context: context,
                      logo: AppAssets.businessIcon,
                      status: controller.selectedPos.value == 0 ? true : false,
                      title: 'Business',
                      onTap: () {
                        controller.selectedPos.value = 0;
                      },
                    ),
                  ),
                  Expanded(
                    child: _buildCard(
                      context: context,
                      logo: AppAssets.facebookIcon,
                      status: controller.selectedPos.value == 1 ? true : false,
                      title: 'Social',
                      onTap: () {
                        controller.selectedPos.value = 1;
                      },
                    ),
                  ),
                  Expanded(
                    child: _buildCard(
                      context: context,
                      logo: AppAssets.youtubeIcon,
                      status: controller.selectedPos.value == 2 ? true : false,
                      title: 'Channel',
                      onTap: () {
                        controller.selectedPos.value = 2;
                      },
                    ),
                  ),
                  Expanded(
                    child: _buildCard(
                      context: context,
                      logo: AppAssets.paymentIcon,
                      status: controller.selectedPos.value == 3 ? true : false,
                      title: 'Payment',
                      onTap: () {
                        controller.selectedPos.value = 3;
                      },
                    ),
                  ),
                  Expanded(
                    child: _buildCard(
                      context: context,
                      logo: AppAssets.offerIcon,
                      status: controller.selectedPos.value == 4 ? true : false,
                      title: 'Our Project',
                      onTap: () {
                        controller.selectedPos.value = 4;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required String logo, required bool status, required VoidCallback onTap, required BuildContext context}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            color: status ? Theme.of(context).primaryColor : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Image.asset(logo, color: status ? Colors.white : Colors.black, height: 20, width: 20),
            ),
          ),
          const SizedBox(height: 2),
          CustomText(title, color: status ? Theme.of(context).primaryColor : Colors.black, weight: FontWeight.w400, size: 12),
        ],
      ),
    );
  }
}
