import 'package:get/get.dart';
import 'package:ndpl/app/modules/youtube/controller.dart';

class YouTubeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YoutubeController>(() => YoutubeController());
  }
}
