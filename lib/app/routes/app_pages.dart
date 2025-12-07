import 'package:get/get.dart';
import 'package:ndpl/app/core/bindings/home.dart';
import 'package:ndpl/app/core/bindings/initial.dart';
import 'package:ndpl/app/core/bindings/upcoming_bindings.dart';
import 'package:ndpl/app/modules/splash/view.dart';
import 'package:ndpl/app/modules/upcoming/view.dart';

import '../modules/home/view.dart';
import 'app_route.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => SplashView(), binding: InitialBinding()),

    GetPage(name: AppRoutes.home, page: () => HomeView(), binding: HomeBinding()),

    GetPage(name: AppRoutes.upcoming, page: () => UpcomingView(), binding: UpcomingBinding()),
  ];
}
