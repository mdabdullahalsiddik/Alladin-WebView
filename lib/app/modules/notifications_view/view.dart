import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndpl/app/global_widgets/app_text.dart';
import 'package:ndpl/app/modules/offer/controller.dart';

class OfferDetailView extends StatelessWidget {
  final Map<String, dynamic> offer;
  OfferDetailView({super.key, required this.offer});

  final OfferController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Our Project Details".tr), elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner Image
              if (offer['banner'] != null && offer['banner'] != "")
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    offer['banner'],
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey.shade300,
                        alignment: Alignment.center,
                        child: const Icon(Icons.broken_image, size: 50),
                      );
                    },
                  ),
                ),
              if (offer['banner'] != null && offer['banner'] != "") const SizedBox(height: 16),

              // Title
              CustomText(offer['title'] ?? '', size: 16, weight: FontWeight.w600, align: TextAlign.start),
              const SizedBox(height: 12),

              // Description
              CustomText(offer['description'] ?? '', size: 14, weight: FontWeight.w400, align: TextAlign.start),
            ],
          ),
        ),
      ),
    );
  }
}
