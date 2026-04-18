import 'package:get/get.dart';
import 'package:vidsnap/app/core/bindings/home.dart';
import 'package:vidsnap/app/core/bindings/initial.dart';
import 'package:vidsnap/app/modules/splash/view.dart';

import '../modules/home/view.dart';
import 'app_route.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => SplashView(), binding: InitialBinding()),
    GetPage(name: AppRoutes.home, page: () => HomeView(), binding: HomeBinding()),
 
  ];
}
