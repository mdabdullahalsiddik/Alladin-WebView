import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wajibmotors/app/core/constant/app_color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String? hintText;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final bool? readOnly;
  final bool? isBorder;
  final bool? isFilled;
  final String? labelText;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final double? borderRadius;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;

  final Color? fillColor;
  final Color? borderSideColor;

  final double? horizontalPadding;

  const CustomTextField({
    super.key,
    this.controller,
    this.textInputAction,
    this.hintText,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText,
    this.readOnly,
    this.isBorder,
    this.isFilled,
    this.labelText,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.borderRadius,
    this.inputFormatters,
    this.focusNode,
    this.fillColor,
    this.borderSideColor,
    this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.headlineMedium?.color;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 6),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly ?? false,
        onChanged: onChanged,
        obscureText: obscureText ?? false,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: readOnly ?? false ? textColor?.withOpacity(0.5) : textColor),
        textInputAction: textInputAction ?? TextInputAction.next,
        keyboardType: keyboardType ?? TextInputType.text,
        inputFormatters: inputFormatters ?? [FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z\s!@#\$%^&*(),.?":{}|<>_-]'))],
        maxLength: maxLength,
        maxLines: maxLines ?? 1,
        minLines: minLines ?? 1,
        validator: validator,
        focusNode: focusNode,
        textAlign: TextAlign.start,

        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          filled: isFilled ?? false,
          fillColor: Colors.white,
          hintText: hintText ?? "Enter text",
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 14, color: textColor?.withOpacity(0.5), fontWeight: FontWeight.w500),
          hintStyle: TextStyle(fontSize: 14, color: textColor?.withOpacity(0.5)),
          errorStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppColor.errorColor),
          border: _buildInputBorder(context),
          enabledBorder: _buildInputBorder(context),
          focusedBorder: _buildInputBorder(context, focused: true),
          errorBorder: _buildErrorBorder(),
          focusedErrorBorder: _buildErrorBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder _buildInputBorder(BuildContext context, {bool focused = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      borderSide: BorderSide(
        color: isBorder == true
            ? Colors.transparent
            : focused
            ? Theme.of(context).colorScheme.primary
            : borderSideColor ?? Colors.grey.shade300,
        width: 1,
      ),
    );
  }

  OutlineInputBorder _buildErrorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      borderSide: const BorderSide(color: AppColor.errorColor, width: 1),
    );
  }
}
