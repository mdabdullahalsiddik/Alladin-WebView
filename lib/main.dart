import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:ndpl/app/core/utils/url_luncher.dart';
import 'package:ndpl/app/data/local/storage.dart';
import 'package:ndpl/app/routes/app_route.dart';

import 'app/core/bindings/initial.dart';
import 'app/core/constant/app_text.dart';
import 'app/core/theme/light.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Important

  Get.put(UrlLuncherController());

  final language = await LocalData().readData(key: "language");


  runApp(MyApp(languageType: (language.isEmpty) ? "bn" : language));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languageType});
  final String languageType;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      title: AppText.appName,
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      theme: AppLightTheme.lightTheme,
      darkTheme: AppLightTheme.lightTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      locale: Locale(languageType),
      fallbackLocale: const Locale('en'),
      // translations: Localization(),
    );
  }
}
