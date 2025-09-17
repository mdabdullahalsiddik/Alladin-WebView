import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndpl/app/data/model/offer.dart';
import 'package:ndpl/app/global_widgets/app_text.dart';
import 'package:ndpl/app/modules/offer_view/view.dart';
import 'package:ndpl/app/modules/offer/controller.dart';

class OfferView extends GetView<OfferController> {
  const OfferView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.offers.isEmpty) {
            return const Center(child: Text("No offers found", style: TextStyle(fontSize: 16)));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [...controller.offers.map((item) => buildOfferItem(item, context)).toList()],
            ),
          );
        }),
      ),
    );
  }

  Widget sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 10),
      child: CustomText(title.tr, size: 18, weight: FontWeight.w600, align: TextAlign.start),
    );
  }

  Widget buildOfferItem(OfferModel item, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => OfferDetailView(offer: item));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: const Offset(0, 3))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.bannerUrl != null && item.bannerUrl != "")
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  item.bannerUrl ?? '',
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 160,
                      color: Colors.grey.shade300,
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image, size: 40),
                    );
                  },
                ),
              ),
            if ( item.bannerUrl != null &&  item.bannerUrl != "") const SizedBox(height: 10),
            CustomText(item.title ?? '', size: 14, weight: FontWeight.w600, align: TextAlign.start),
            const SizedBox(height: 9),
            CustomText(item.description ?? '', size: 13, weight: FontWeight.w400, align: TextAlign.start, maxLines: 2),
          ],
        ),
      ),
    );
  }
}
