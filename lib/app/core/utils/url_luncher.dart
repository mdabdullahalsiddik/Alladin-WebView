import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLuncherController extends GetxController {
  /// Open WhatsApp with a specific phone number and optional message
  Future<void> openWhatsApp(String phone, {String message = ""}) async {
    final Uri uri = Uri.parse("https://wa.me/$phone?text=${Uri.encodeComponent(message)}");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar("Error", "Could not open WhatsApp", snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// Open Email Client
  Future<void> sendEmail(String email, {String subject = "", String body = ""}) async {
    final Uri uri = Uri.parse("mailto:$email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar("Error", "Could not open Email app", snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// Open Website with automatic URL sanitization
  Future<void> openWebsite(String url) async {
    final Uri uri = Uri.parse(_sanitizeUrl(url));
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar("Error", "Could not open website", snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// Make a phone call
  Future<void> phoneCall(String phone) async {
    final Uri uri = Uri.parse("tel:$phone");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar("Error", "Could not make a phone call", snackPosition: SnackPosition.BOTTOM);
    }
  }
 /// Location
  Future<void> openLocationByAddress(String address) async {
  final Uri uri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}");
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    Get.snackbar("Error", "Could not open Google Maps",
        snackPosition: SnackPosition.BOTTOM);
  }
}

Future<void> openLocation(double latitude, double longitude) async {
  final Uri uri = Uri.parse("https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    Get.snackbar("Error", "Could not open Google Maps", snackPosition: SnackPosition.BOTTOM);
  }
}



  /// Add https:// if missing from URL
  String _sanitizeUrl(String url) {
    return url.startsWith('http') ? url : 'https://$url';
  }
}
