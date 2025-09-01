import 'package:get/get.dart';
import 'package:ndpl/app/modules/offer/controller.dart';

class OfferBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OfferController());
  }
}
