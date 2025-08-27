import 'package:get/get.dart';
import 'package:ndpl/app/modules/facebook/controller.dart';

class FacebookBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FacebookController>(() => FacebookController());
  }
}
