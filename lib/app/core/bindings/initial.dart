import 'package:get/get.dart';
import 'package:ndpl/app/modules/splash/controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    // Only global & startup controllers

    //  Get.lazyPut<HomeController>(() => HomeController());
    //   Get.lazyPut<DocumentsController>(() => DocumentsController());
    //   Get.lazyPut<ProfileController>(() => ProfileController());
    //      Get.lazyPut<LoginController>(() => LoginController());
  }
}
