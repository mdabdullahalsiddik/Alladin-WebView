import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final double? height;
  final String? fontFamily;

  const CustomText(
    this.text, {
    Key? key,
    this.size,
    this.weight,
    this.color,
    this.align,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.height,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: align,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight ?? FontWeight.w800,
        color: color,
        decoration: decoration,
        fontFamily: fontFamily ?? "Inter",
        height: height,
      ),
    );
  }
}
