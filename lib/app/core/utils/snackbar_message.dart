import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonSnackBarMessage {
  static noInternetConnection() {
    Get.snackbar(
      "You are Offline !!",
      "Please check internet connection.",
      backgroundColor: Colors.red.shade50,
      colorText: Colors.redAccent,
      maxWidth: 300,
      snackStyle: SnackStyle.FLOATING,
      duration: const Duration(seconds: 1),
      overlayBlur: 5,
      icon: const Icon(Icons.wifi_off_outlined, color: Colors.red),
      snackPosition: SnackPosition.TOP,
    );
  }

  static errorMessage({String? title, required String text}) {
    Get.snackbar(
      title ?? "Message",
      text,
      maxWidth: 300,
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Colors.red.shade50,
      duration: const Duration(seconds: 2),
      overlayBlur: 3,
      icon: const Icon(Icons.error, color: Colors.red),
      colorText: Colors.red,
      snackPosition: SnackPosition.TOP,
    );
  }

  static successMessage({String? title, required String text, IconData? icon}) {
    Get.snackbar(
      title ?? "Successful".tr,
      text,
      maxWidth: 300,
      icon: Icon(icon ?? Icons.verified_user_sharp, color: Colors.white),
      backgroundColor: Color(0xff002B5B),
      duration: const Duration(seconds: 2),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  static serverError({String? errorSign}) {
    Get.snackbar(
      "Opps..!!",
      "${errorSign ?? ""} Something went wrong. Please try again later.",
      maxWidth: 300,
      icon: Icon(Icons.logout_outlined, color: Colors.red),
      backgroundColor: Colors.red.shade50,
      duration: const Duration(seconds: 2),
      colorText: Colors.red,
      snackPosition: SnackPosition.TOP,
    );
  }

  static tokenExpire() {
    Get.snackbar(
      "Season Expire",
      "Please logout and login again.",
      maxWidth: 300,
      icon: Icon(Icons.public, color: Colors.red),
      backgroundColor: Colors.red.shade50,
      duration: const Duration(seconds: 2),
      colorText: Colors.red,
      snackPosition: SnackPosition.TOP,
    );
  }

  static accessDenied({required permission}) {
    Get.snackbar(
      "$permission Access Denied",
      "Please contact with Admin for give permission.",
      maxWidth: 300,
      icon: Icon(Icons.public, color: Colors.red),
      backgroundColor: Colors.red.shade50,
      duration: const Duration(seconds: 2),
      colorText: Colors.red,
      snackPosition: SnackPosition.TOP,
    );
  }
}
