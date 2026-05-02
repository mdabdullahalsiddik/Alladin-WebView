import 'package:alladin/app/core/bindings/home.dart';
import 'package:alladin/app/core/bindings/initial.dart';
import 'package:alladin/app/modules/no_internet/no_internet_bindings.dart';
import 'package:alladin/app/modules/no_internet/no_internet_page.dart';
import 'package:alladin/app/modules/splash/view.dart';
import 'package:get/get.dart';

import '../modules/home/view.dart';
import 'app_route.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => SplashView(), binding: InitialBinding(), transition: Transition.fadeIn),
    GetPage(name: AppRoutes.home, page: () => HomeView(), binding: HomeBinding(), transition: Transition.fadeIn),
    GetPage(name: AppRoutes.noInternet, page: () => NoInternetPage(), binding: NoInternetBindings(), transition: Transition.fadeIn),
  ];
}
