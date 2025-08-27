import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppSettings {
  /// change App Safe area background color
  static void appSafeAreaColorControl({required BuildContext context}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: true,
      ),
    );
  }

  /// Easyloading Indicator Settings
  static easyloadingSetting({required BuildContext context}) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 500)
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Theme.of(context).primaryColor
      ..indicatorColor = Theme.of(context).scaffoldBackgroundColor
      ..maskColor = Theme.of(context).primaryColor
      ..textColor = Theme.of(context).scaffoldBackgroundColor
      ..contentPadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
      ..indicatorType = EasyLoadingIndicatorType.fadingGrid
      ..userInteractions = false
      ..successWidget = Icon(
        Icons.check_circle_rounded,
        color: Theme.of(context).scaffoldBackgroundColor,
        size: 40,
      )
      ..errorWidget = Icon(
        Icons.error_outline,
        color: Theme.of(context).scaffoldBackgroundColor,
        size: 30,
      )
      ..dismissOnTap = false;
  }
}
