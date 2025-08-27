import 'package:get/get.dart';

import '../../modules/welcome/controller.dart';

class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
   Get.lazyPut<WelcomeController>(() => WelcomeController());
  }
}
