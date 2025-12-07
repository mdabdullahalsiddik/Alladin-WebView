import 'package:get/get.dart';
import 'package:wajibmotors/app/modules/home/controller.dart';
import 'package:wajibmotors/app/modules/splash/controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());

    Get.lazyPut<HomeController>(() => HomeController());
  }
}
