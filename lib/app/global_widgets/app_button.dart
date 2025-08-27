import 'package:flutter/material.dart';
import 'package:ndpl/app/global_widgets/app_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.height,
    this.width,
    this.fontSize,
    this.fWeight,
    this.onTap,
    this.textColor,
    this.color,
    this.borderRadius,
    this.fontFamily,
    this.borderColor,
  });

  final String title;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? textColor;
  final Color? color;
  final FontWeight? fWeight;
  final VoidCallback? onTap;
  final double? borderRadius;
  final String? fontFamily;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          border: Border.all(color: borderColor ?? Theme.of(context).primaryColor),
          color: color ?? Theme.of(context).primaryColor,
        ),

        child: SizedBox(
          height: height ?? 50,
          width: width ?? 266,
          child: Center(
            child: CustomText(
              title,
              fontFamily: fontFamily ?? "Inter",
              size: fontSize ?? 18,
              weight: fWeight ?? FontWeight.bold,
              color: textColor ?? Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
