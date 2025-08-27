// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:ndpl/app/core/constant/assets.dart';
import 'package:ndpl/app/data/local/storage.dart';
import 'package:ndpl/app/global_widgets/app_button.dart';
import 'package:ndpl/app/routes/app_route.dart';

import 'controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  WelcomeView({super.key});
  @override
  final WelcomeController controller = Get.put(WelcomeController());
  final PageController pageController = PageController();
  static const int totalPages = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 8),

              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Column(
                        children: [
                          Expanded(child: _pages()),
                          // const SizedBox(height: 16),
                          Obx(() => buildPageIndicator(context, controller.currentPage.value)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 64),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppButton(
                        onTap: () async {
                          log(pageController.positions.first.maxScrollExtent.toString());
                          log(controller.currentPage.toString());

                          if (controller.currentPage.value == totalPages - 1) {
                            log("Last page reached");
                            await LocalData().writeData(key: 'isWelcome', value: 'true');
                            Get.offAllNamed(AppRoutes.navBar);
                          } else {
                            pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                          }
                        },

                        title: "Continue".tr,
                        height: 47,
                        width: MediaQuery.of(context).size.width,
                        borderRadius: 15,
                        fontSize: 18,
                        fWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PageView _pages() {
    return PageView(
      controller: pageController,
      onPageChanged: controller.changePage,
      children: [
        buildPage(
          image: AppAssets.welcome1,
          description:
              """
<div style="text-align: center;">
  <h2>${'Complete BMET Registration in Just 5 Minutes!'.tr}</h2>
  <p>${'Complete mandatory BMET database registration on the Ami Probashi App in just 5 minutes.'.tr}</p>
</div>
""",
        ),
        buildPage(
          image: AppAssets.welcome2,
          description:
              """
            <div style="text-align: center;">
              <h2>${'Connect with Your Homeland'.tr}</h2>
              <p>${'Find Bangladeshi communities, businesses, and services around you.'.tr}</p>
            </div>
          """,
        ),
        buildPage(
          image: AppAssets.welcome3,
          description:
              """
            <div style="text-align: center;">
              <h2>${'Find Jobs & Services Easily'.tr}</h2>
              <p>${'Browse and apply for jobs, connect with service providers instantly.'.tr}</p>
            </div>
          """,
        ),
        buildPage(
          image: AppAssets.welcome4,
          description:
              """
            <div style="text-align: center;">
              <h2>${'Stay Updated with Local News'.tr}</h2>
              <p>${'Get the latest news and updates from your community and home country.'.tr}</p>
            </div>
          """,
        ),
        buildPage(
          image: AppAssets.welcome5,
          description:
              """
            <div style="text-align: center;">
              <h2>${'Join a Trusted Community'.tr}</h2>
              <p>${'Be part of a supportive network of fellow Bangladeshis living abroad.'.tr}</p>
            </div>
          """,
        ),
      ],
    );
  }

  Widget buildPage({required String image, required String description}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, width: 200, height: 200, fit: BoxFit.fill),
        const SizedBox(height: 16),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: HtmlWidget(description)),
      ],
    );
  }

  Widget buildPageIndicator(BuildContext context, int currentPage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        final isActive = currentPage == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 14 : 6,
          height: 6,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: isActive ? Theme.of(context).primaryColor : Colors.grey.shade300),
        );
      }),
    );
  }
}
