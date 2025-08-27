import 'package:get/get.dart';
import '../../modules/upcoming/controller.dart';

class UpcomingBinding implements Bindings {
    @override
    void dependencies() {
        Get.lazyPut(() => UpcomingController());
    }
}