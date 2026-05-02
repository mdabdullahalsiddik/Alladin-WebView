import 'package:get/get.dart';
import 'package:alladin/app/modules/home/controller.dart';
import 'package:alladin/app/modules/splash/controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());

    Get.lazyPut<HomeController>(() => HomeController());
  }
}
