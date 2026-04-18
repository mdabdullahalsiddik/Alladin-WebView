import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:vidsnap/app/routes/app_route.dart';

import 'app/core/bindings/initial.dart';
import 'app/core/constant/app_text.dart';
import 'app/core/theme/light.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      locale: Locale('en'),
      fallbackLocale: const Locale('en'),
    );
  }
}
