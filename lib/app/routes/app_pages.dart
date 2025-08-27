import 'package:get/get.dart';
import 'package:ndpl/app/core/bindings/facebook.dart';
import 'package:ndpl/app/core/bindings/home.dart';
import 'package:ndpl/app/core/bindings/initial.dart';
import 'package:ndpl/app/core/bindings/nav_bar.dart';
import 'package:ndpl/app/core/bindings/upcoming_bindings.dart';
import 'package:ndpl/app/core/bindings/welcome.dart';
import 'package:ndpl/app/core/bindings/youtube.dart';
import 'package:ndpl/app/modules/bottom_navbar/view.dart';
import 'package:ndpl/app/modules/facebook/view.dart';
import 'package:ndpl/app/modules/splash/view.dart';
import 'package:ndpl/app/modules/upcoming/view.dart';
import 'package:ndpl/app/modules/welcome/view.dart';
import 'package:ndpl/app/modules/youtube/view.dart';

import '../modules/home/view.dart';
import 'app_route.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => SplashView(), binding: InitialBinding()),
    GetPage(name: AppRoutes.welcome, page: () => WelcomeView(), binding: WelcomeBinding()),
    GetPage(name: AppRoutes.navBar, page: () => BottomNavBarView(), binding: NavBarBinding()),
    GetPage(name: AppRoutes.home, page: () => HomeView(), binding: HomeBinding()),

    GetPage(name: AppRoutes.facebook, page: () => FacebookView(), binding: FacebookBinding()),
    GetPage(name: AppRoutes.youtube, page: () => YouTubeView(), binding: YouTubeBinding()),
    GetPage(name: AppRoutes.youtube, page: () => YouTubeView(), binding: FacebookBinding()),
    GetPage(name: AppRoutes.upcoming, page: () => UpcomingView(), binding: UpcomingBinding()),
  ];
}
