import 'package:get/get.dart';
import 'package:ndpl/app/modules/bottom_navbar/controller.dart';
import 'package:ndpl/app/modules/facebook/controller.dart';
import 'package:ndpl/app/modules/home/controller.dart';
import 'package:ndpl/app/modules/offer/controller.dart';
import 'package:ndpl/app/modules/youtube/controller.dart';

class NavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavBarController>(() => BottomNavBarController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<OfferController>(() => OfferController());

    Get.lazyPut<YoutubeController>(() => YoutubeController());
    Get.lazyPut<FacebookController>(() => FacebookController());
  }
}
