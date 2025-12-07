import 'package:flutter/material.dart';
import 'package:wajibmotors/app/global_widgets/app_text.dart';

void CustomDialog(
  BuildContext context, {
  required String title,
  required String message,
  required VoidCallback onTap,
  required String confirmText,
  required String imageAsset, // replace with default asset
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            insetPadding: const EdgeInsets.all(8),
            child: Container(
              width: constraints.maxWidth - 40,
              padding: const EdgeInsets.all(32),
              child: Column(
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(height: 8),
                  Image.asset(imageAsset, width: 70, height: 70, fit: BoxFit.fill),

                  CustomText(title, size: 20, weight: FontWeight.w600, align: TextAlign.center),

                  CustomText(message, size: 12, align: TextAlign.center, weight: FontWeight.w400),
                  Container(height: 8),
                  InkWell(
                    onTap: onTap,
                    child: Card(
                      color: Theme.of(context).primaryColor,
                      child: SizedBox(
                        height: 50,
                        width: double.maxFinite,
                        child: Center(
                          child: CustomText(confirmText, color: Theme.of(context).canvasColor, size: 16, weight: FontWeight.w600),
                        ),
                      ),
                    ),
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
