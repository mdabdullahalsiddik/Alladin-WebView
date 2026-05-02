import 'package:get/get.dart';

import './no_internet_controller.dart';

class NoInternetBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoInternetController>(() => NoInternetController());
  }
}
