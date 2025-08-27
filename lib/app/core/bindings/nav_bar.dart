import 'package:get/get.dart';
import 'package:ndpl/app/modules/bottom_navbar/controller.dart';

class NavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavBarController>(() => BottomNavBarController());
  }
}
